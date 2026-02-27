/// The details of the Amazon Redshift Serverless workgroup storage.
pub const RedshiftServerlessStorage = struct {
    /// The name of the Amazon Redshift Serverless workgroup.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .workgroup_name = "workgroupName",
    };
};
