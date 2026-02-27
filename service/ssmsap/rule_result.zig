const aws = @import("aws");

const RuleResultStatus = @import("rule_result_status.zig").RuleResultStatus;

/// Represents the result of a single rule within a configuration check.
pub const RuleResult = struct {
    /// A description of what the rule validates.
    description: ?[]const u8,

    /// The unique identifier of the rule result.
    id: ?[]const u8,

    /// A message providing details about the rule result.
    message: ?[]const u8,

    /// Additional metadata associated with the rule result.
    metadata: ?[]const aws.map.StringMapEntry,

    /// The status of the rule result.
    status: ?RuleResultStatus,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .message = "Message",
        .metadata = "Metadata",
        .status = "Status",
    };
};
