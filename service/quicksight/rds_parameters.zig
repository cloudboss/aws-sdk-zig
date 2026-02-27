/// The parameters for Amazon RDS.
pub const RdsParameters = struct {
    /// Database.
    database: []const u8,

    /// Instance ID.
    instance_id: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .instance_id = "InstanceId",
    };
};
