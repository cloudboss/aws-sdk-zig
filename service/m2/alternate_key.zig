/// Defines an alternate key. This value is optional. A legacy data set might
/// not have any
/// alternate key defined but if those alternate keys definitions exist, provide
/// them, as some
/// applications will make use of them.
pub const AlternateKey = struct {
    /// Indicates whether the alternate key values are supposed to be unique for the
    /// given data
    /// set.
    allow_duplicates: bool = false,

    /// A strictly positive integer value representing the length of the alternate
    /// key.
    length: i32 = 0,

    /// The name of the alternate key.
    name: ?[]const u8,

    /// A positive integer value representing the offset to mark the start of the
    /// alternate key
    /// part in the record byte array.
    offset: i32 = 0,

    pub const json_field_names = .{
        .allow_duplicates = "allowDuplicates",
        .length = "length",
        .name = "name",
        .offset = "offset",
    };
};
