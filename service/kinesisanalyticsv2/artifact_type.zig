pub const ArtifactType = enum {
    udf,
    dependency_jar,

    pub const json_field_names = .{
        .udf = "UDF",
        .dependency_jar = "DEPENDENCY_JAR",
    };
};
