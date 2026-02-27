/// Specifies the visibility of the project's builds. Possible values are:
///
/// **PUBLIC_READ**
///
/// The project builds are visible to the public.
///
/// **PRIVATE**
///
/// The project builds are not visible to the public.
pub const ProjectVisibilityType = enum {
    public_read,
    private,

    pub const json_field_names = .{
        .public_read = "PUBLIC_READ",
        .private = "PRIVATE",
    };
};
