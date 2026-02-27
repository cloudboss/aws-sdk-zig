/// An object that describes the VPC configuration for a table optimizer.
///
/// This configuration is necessary to perform optimization on tables that are
/// in a customer VPC.
pub const TableOptimizerVpcConfiguration = union(enum) {
    /// The name of the Glue connection used for the VPC for the table optimizer.
    glue_connection_name: ?[]const u8,

    pub const json_field_names = .{
        .glue_connection_name = "glueConnectionName",
    };
};
