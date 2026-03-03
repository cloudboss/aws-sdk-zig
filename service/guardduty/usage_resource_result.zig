const Total = @import("total.zig").Total;

/// Contains information on the sum of usage based on an Amazon Web Services
/// resource.
pub const UsageResourceResult = struct {
    /// The Amazon Web Services resource that generated usage.
    resource: ?[]const u8 = null,

    /// Represents the sum total of usage for the specified resource type.
    total: ?Total = null,

    pub const json_field_names = .{
        .resource = "Resource",
        .total = "Total",
    };
};
