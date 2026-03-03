/// The MLflow properties of a connection.
pub const MlflowPropertiesOutput = struct {
    /// The tracking server ARN as part of the MLflow properties of a connection.
    tracking_server_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .tracking_server_arn = "trackingServerArn",
    };
};
