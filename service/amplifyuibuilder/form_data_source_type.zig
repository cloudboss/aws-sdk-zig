pub const FormDataSourceType = enum {
    /// Will use a provided Amplify DataStore enabled API
    datastore,
    /// Will use passed in hooks to use when creating a form from scratch
    custom,

    pub const json_field_names = .{
        .datastore = "DATASTORE",
        .custom = "CUSTOM",
    };
};
