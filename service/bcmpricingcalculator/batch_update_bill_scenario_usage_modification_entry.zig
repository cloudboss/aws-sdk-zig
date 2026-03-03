const UsageAmount = @import("usage_amount.zig").UsageAmount;

/// Represents an entry in a batch operation to update bill scenario usage
/// modifications.
pub const BatchUpdateBillScenarioUsageModificationEntry = struct {
    /// The updated usage amounts for the modification.
    amounts: ?[]const UsageAmount = null,

    /// The updated group identifier for the usage modification.
    group: ?[]const u8 = null,

    /// The unique identifier of the usage modification to update.
    id: []const u8,

    pub const json_field_names = .{
        .amounts = "amounts",
        .group = "group",
        .id = "id",
    };
};
