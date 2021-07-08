using KernelGradients
using KernelAbstractions
using Test

include("testsuite.jl")

backend = get(ENV, "KERNELABSTRACTIONS_TEST_BACKEND", "CPU")

if backend == "ROCM"
    using ROCKernels
    using AMDGPU

    if length(AMDGPU.get_agents(:gpu)) > 0
        AMDGPU.allowscalar(false)
        Testsuite.testsuite(ROCDevice, backend, AMDGPU, ROCArray, AMDGPU.ROCDeviceArray)
    else
        error("No AMD GPUs available!")
    end
elseif backend == "CUDA"
    using CUDA
    using CUDAKernels

    CUDA.versioninfo()
    if CUDA.functional(true)
        CUDA.allowscalar(false)
        Testsuite.testsuite(CUDADevice, backend, CUDA, CuArray, CUDA.CuDeviceArray)
    else
        error("No CUDA GPUs available!")
    end
elseif backend == "CPU"
    struct CPUDeviceArray{T,N,A} end # Fake and unused
    Testsuite.testsuite(CPU, backend, Base, Array, CPUDeviceArray)
end
