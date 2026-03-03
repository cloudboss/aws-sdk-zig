/// The primary key for a KSDS data set.
pub const PrimaryKey = struct {
    /// A strictly positive integer value representing the length of the primary
    /// key.
    length: i32 = 0,

    /// A name for the Primary Key.
    name: ?[]const u8 = null,

    /// A positive integer value representing the offset to mark the start of the
    /// primary key in
    /// the record byte array.
    offset: i32 = 0,

    pub const json_field_names = .{
        .length = "length",
        .name = "name",
        .offset = "offset",
    };
};
