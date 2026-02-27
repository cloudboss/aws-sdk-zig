const LambdaConfig = @import("lambda_config.zig").LambdaConfig;

/// The integration data source configuration for the handler.
pub const Integration = struct {
    /// The unique name of the data source that has been configured on the API.
    data_source_name: []const u8,

    /// The configuration for a Lambda data source.
    lambda_config: ?LambdaConfig,

    pub const json_field_names = .{
        .data_source_name = "dataSourceName",
        .lambda_config = "lambdaConfig",
    };
};
