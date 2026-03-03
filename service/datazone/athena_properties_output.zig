/// The Amazon Athena properties of a connection.
pub const AthenaPropertiesOutput = struct {
    /// The Amazon Athena workgroup name of a connection.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .workgroup_name = "workgroupName",
    };
};
