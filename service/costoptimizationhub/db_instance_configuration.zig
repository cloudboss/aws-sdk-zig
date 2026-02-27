/// The DB instance configuration used for recommendations.
pub const DbInstanceConfiguration = struct {
    /// The DB instance class of the DB instance.
    db_instance_class: ?[]const u8,

    pub const json_field_names = .{
        .db_instance_class = "dbInstanceClass",
    };
};
