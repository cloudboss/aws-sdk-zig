const aws = @import("aws");

const ThrottleSettings = @import("throttle_settings.zig").ThrottleSettings;

/// API stage name of the associated API stage in a usage plan.
pub const ApiStage = struct {
    /// API Id of the associated API stage in a usage plan.
    api_id: ?[]const u8,

    /// API stage name of the associated API stage in a usage plan.
    stage: ?[]const u8,

    /// Map containing method level throttling information for API stage in a usage
    /// plan.
    throttle: ?[]const aws.map.MapEntry(ThrottleSettings),

    pub const json_field_names = .{
        .api_id = "apiId",
        .stage = "stage",
        .throttle = "throttle",
    };
};
