import .ROCKernels: ROCCTX, ROCCtx
import Cassette
import Enzyme

@inline function Cassette.overdub(::ROCCtx, ::typeof(Enzyme.autodiff), f, args...)
    f′ = (args...) -> (Base.@_inline_meta; Cassette.overdub(ROCCTX, f, args...))
    Enzyme.autodiff(f′, args...)
end
