import Pkg

pkgs = [
    "KernelAbstractions",
]

backend = get(ENV, "KERNELABSTRACTIONS_TEST_BACKEND", nothing)

if !(VERSION < v"1.6-")
    if backend === nothing || backend == "ROCM"
        push!(pkgs, "ROCKernels")
    end
    if backend === nothing || backend == "CUDA"
        push!(pkgs, "CUDAKernels")
    end
    push!(pkgs, "KernelGradients")
end

Pkg.test(pkgs; coverage = true)
