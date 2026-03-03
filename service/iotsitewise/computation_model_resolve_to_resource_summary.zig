const ResolveTo = @import("resolve_to.zig").ResolveTo;

/// A summary of the resource that a computation model resolves to.
pub const ComputationModelResolveToResourceSummary = struct {
    resolve_to: ?ResolveTo = null,

    pub const json_field_names = .{
        .resolve_to = "resolveTo",
    };
};
