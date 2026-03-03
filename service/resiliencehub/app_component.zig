const aws = @import("aws");

/// Defines an Application Component.
pub const AppComponent = struct {
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter accepts a key-value mapping (in a string format)
    /// of only one failover region and one associated account.
    ///
    /// Key: `"failover-regions"`
    ///
    /// Value: `"[{"region":"<REGION>", "accounts":[{"id":"<ACCOUNT_ID>"}]}]"`
    additional_info: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Identifier of the Application Component.
    id: ?[]const u8 = null,

    /// Name of the Application Component.
    name: []const u8,

    /// The type of Application Component.
    @"type": []const u8,

    pub const json_field_names = .{
        .additional_info = "additionalInfo",
        .id = "id",
        .name = "name",
        .@"type" = "type",
    };
};
