/// Provide expiration lifecycle details of Amazon Security Lake object.
pub const DataLakeLifecycleExpiration = struct {
    /// Number of days before data expires in the Amazon Security Lake object.
    days: ?i32,

    pub const json_field_names = .{
        .days = "days",
    };
};
