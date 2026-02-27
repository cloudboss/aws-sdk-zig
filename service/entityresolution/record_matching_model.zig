pub const RecordMatchingModel = enum {
    one_source_to_one_target,
    many_source_to_one_target,

    pub const json_field_names = .{
        .one_source_to_one_target = "ONE_SOURCE_TO_ONE_TARGET",
        .many_source_to_one_target = "MANY_SOURCE_TO_ONE_TARGET",
    };
};
