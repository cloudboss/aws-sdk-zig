/// The value type of the parameter. The value type is used to validate the
/// parameter before it is evaluated.
pub const DatasetParameterValueType = enum {
    multi_valued,
    single_valued,

    pub const json_field_names = .{
        .multi_valued = "MULTI_VALUED",
        .single_valued = "SINGLE_VALUED",
    };
};
