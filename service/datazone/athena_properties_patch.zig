/// The Amazon Athena properties patch of a connection.
pub const AthenaPropertiesPatch = struct {
    /// The Amazon Athena workgroup name of a connection.
    workgroup_name: ?[]const u8,

    pub const json_field_names = .{
        .workgroup_name = "workgroupName",
    };
};
