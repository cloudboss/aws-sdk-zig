/// Specifies the political view for the style.
pub const MapConfigurationUpdate = struct {
    /// Specifies the custom layers for the style. Leave unset to not enable any
    /// custom layer, or, for styles that support custom layers, you can enable
    /// layer(s), such as POI layer for the VectorEsriNavigation style. Default is
    /// `unset`.
    ///
    /// Not all map resources or styles support custom layers. See Custom Layers for
    /// more information.
    custom_layers: ?[]const []const u8 = null,

    /// Specifies the political view for the style. Set to an empty string to not
    /// use a political view, or, for styles that support specific political views,
    /// you can choose a view, such as `IND` for the Indian view.
    ///
    /// Not all map resources or styles support political view styles. See
    /// [Political
    /// views](https://docs.aws.amazon.com/location/previous/developerguide/map-concepts.html#political-views) for more information.
    political_view: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_layers = "CustomLayers",
        .political_view = "PoliticalView",
    };
};
