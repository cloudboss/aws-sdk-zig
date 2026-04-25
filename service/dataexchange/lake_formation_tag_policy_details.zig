/// Extra details specific to the affected scope in this LF data set.
pub const LakeFormationTagPolicyDetails = struct {
    /// The underlying Glue database that the notification is referring to.
    database: ?[]const u8 = null,

    /// The underlying Glue table that the notification is referring to.
    table: ?[]const u8 = null,

    pub const json_field_names = .{
        .database = "Database",
        .table = "Table",
    };
};
