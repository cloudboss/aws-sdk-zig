/// A preference indicating a choice to use 63bit/32bit IDs for all applicable
/// resources.
pub const ResourceIdType = enum {
    long_id,
    short_id,

    pub const json_field_names = .{
        .long_id = "LongId",
        .short_id = "ShortId",
    };
};
