const Transferable = @import("transferable.zig").Transferable;

/// A complex type that contains information about whether the specified domain
/// can be
/// transferred to Route 53.
pub const DomainTransferability = struct {
    transferable: ?Transferable = null,

    pub const json_field_names = .{
        .transferable = "Transferable",
    };
};
