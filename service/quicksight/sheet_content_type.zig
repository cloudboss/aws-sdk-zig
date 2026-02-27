pub const SheetContentType = enum {
    paginated,
    interactive,

    pub const json_field_names = .{
        .paginated = "PAGINATED",
        .interactive = "INTERACTIVE",
    };
};
