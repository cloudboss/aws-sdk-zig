pub const CustomPluginContentType = enum {
    jar,
    zip,

    pub const json_field_names = .{
        .jar = "JAR",
        .zip = "ZIP",
    };
};
