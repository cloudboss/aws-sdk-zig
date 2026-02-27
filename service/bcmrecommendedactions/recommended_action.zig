const aws = @import("aws");

const Feature = @import("feature.zig").Feature;
const Severity = @import("severity.zig").Severity;
const ActionType = @import("action_type.zig").ActionType;

/// Describes a specific recommended action.
pub const RecommendedAction = struct {
    /// The account that the recommended action is for.
    account_id: ?[]const u8,

    /// Context that applies to the recommended action.
    context: ?[]const aws.map.StringMapEntry,

    /// The feature associated with the recommended action.
    feature: ?Feature,

    /// The ID for the recommended action.
    id: ?[]const u8,

    /// The time when the recommended action status was last updated.
    last_updated_time_stamp: ?[]const u8,

    /// The possible next steps to execute the recommended action.
    next_steps: ?[]const []const u8,

    /// The severity associated with the recommended action.
    severity: ?Severity,

    /// The type of action you can take by adopting the recommended action.
    @"type": ?ActionType,

    pub const json_field_names = .{
        .account_id = "accountId",
        .context = "context",
        .feature = "feature",
        .id = "id",
        .last_updated_time_stamp = "lastUpdatedTimeStamp",
        .next_steps = "nextSteps",
        .severity = "severity",
        .@"type" = "type",
    };
};
