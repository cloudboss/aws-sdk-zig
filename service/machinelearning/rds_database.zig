/// The database details of an Amazon RDS database.
pub const RDSDatabase = struct {
    database_name: []const u8,

    /// The ID of an RDS DB instance.
    instance_identifier: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .instance_identifier = "InstanceIdentifier",
    };
};
