/// Specify the details for each additional DASH manifest that you want the
/// service to generate for this output group. Each manifest can reference a
/// different subset of outputs in the group.
pub const DashAdditionalManifest = struct {
    /// Specify a name modifier that the service adds to the name of this manifest
    /// to make it different from the file names of the other main manifests in the
    /// output group. For example, say that the default main manifest for your DASH
    /// group is film-name.mpd. If you enter "-no-premium" for this setting, then
    /// the file name the service generates for this top-level manifest is
    /// film-name-no-premium.mpd.
    manifest_name_modifier: ?[]const u8 = null,

    /// Specify the outputs that you want this additional top-level manifest to
    /// reference.
    selected_outputs: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .manifest_name_modifier = "ManifestNameModifier",
        .selected_outputs = "SelectedOutputs",
    };
};
