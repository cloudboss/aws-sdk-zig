pub const HITAccessActions = enum {
    accept,
    preview_and_accept,
    discover_preview_and_accept,

    pub const json_field_names = .{
        .accept = "Accept",
        .preview_and_accept = "PreviewAndAccept",
        .discover_preview_and_accept = "DiscoverPreviewAndAccept",
    };
};
