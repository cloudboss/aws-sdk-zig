const DbInstanceConfiguration = @import("db_instance_configuration.zig").DbInstanceConfiguration;

/// The Amazon RDS DB instance configuration used for recommendations.
pub const RdsDbInstanceConfiguration = struct {
    /// Details about the instance configuration.
    instance: ?DbInstanceConfiguration,

    pub const json_field_names = .{
        .instance = "instance",
    };
};
