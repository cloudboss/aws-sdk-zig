pub const LayerFailureCode = enum {
    invalid_layer_digest,
    missing_layer_digest,

    pub const json_field_names = .{
        .invalid_layer_digest = "InvalidLayerDigest",
        .missing_layer_digest = "MissingLayerDigest",
    };
};
