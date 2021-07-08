import Pkg

Pkg.update()

root_directory = dirname(@__DIR__)

backend = get(ENV, "KERNELABSTRACTIONS_TEST_BACKEND", nothing)

kernelabstractions = Pkg.PackageSpec(path = root_directory)
Pkg.develop(kernelabstractions)

if !(VERSION < v"1.6-")
    if backend === nothing || backend == "ROCM"
        rockernels = Pkg.PackageSpec(path = joinpath(root_directory, "lib", "ROCKernels"))
        Pkg.develop(rockernels)
    end

    if backend === nothing || backend == "CUDA"
        cudakernels = Pkg.PackageSpec(path = joinpath(root_directory, "lib", "CUDAKernels"))
        Pkg.develop(cudakernels)
    end

    kernelgradients = Pkg.PackageSpec(path = joinpath(root_directory, "lib", "KernelGradients"))
    Pkg.develop(kernelgradients)
end
Pkg.build()
Pkg.precompile()
