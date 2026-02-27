pub const ResourceConfigurationType = enum {
    /// Resource Configuration of type GROUP
    group,
    /// Resource Configuration of type CHILD
    child,
    /// Resource Configuration of type SINGLE
    single,
    /// Resource Configuration of type ARN
    arn,

    pub const json_field_names = .{
        .group = "GROUP",
        .child = "CHILD",
        .single = "SINGLE",
        .arn = "ARN",
    };
};
