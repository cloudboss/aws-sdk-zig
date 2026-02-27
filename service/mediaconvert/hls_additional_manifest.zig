/// Specify the details for each additional HLS manifest that you want the
/// service to generate for this output group. Each manifest can reference a
/// different subset of outputs in the group.
pub const HlsAdditionalManifest = struct {
    /// Specify a name modifier that the service adds to the name of this manifest
    /// to make it different from the file names of the other main manifests in the
    /// output group. For example, say that the default main manifest for your HLS
    /// group is film-name.m3u8. If you enter "-no-premium" for this setting, then
    /// the file name the service generates for this top-level manifest is
    /// film-name-no-premium.m3u8. For HLS output groups, specify a
    /// manifestNameModifier that is different from the nameModifier of the output.
    /// The service uses the output name modifier to create unique names for the
    /// individual variant manifests.
    manifest_name_modifier: ?[]const u8,

    /// Specify the outputs that you want this additional top-level manifest to
    /// reference.
    selected_outputs: ?[]const []const u8,

    pub const json_field_names = .{
        .manifest_name_modifier = "ManifestNameModifier",
        .selected_outputs = "SelectedOutputs",
    };
};
