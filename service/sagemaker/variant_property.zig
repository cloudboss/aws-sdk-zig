const VariantPropertyType = @import("variant_property_type.zig").VariantPropertyType;

/// Specifies a production variant property type for an Endpoint.
///
/// If you are updating an endpoint with the `RetainAllVariantProperties` option
/// of
/// [UpdateEndpointInput](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpoint.html) set to `true`, the `VariantProperty` objects listed in the `ExcludeRetainedVariantProperties` parameter of [UpdateEndpointInput](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpoint.html) override the existing variant properties of the endpoint.
pub const VariantProperty = struct {
    /// The type of variant property. The supported values are:
    ///
    /// * `DesiredInstanceCount`: Overrides the existing variant instance counts
    ///   using the `InitialInstanceCount` values in the `ProductionVariants` of
    ///   [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html).
    /// * `DesiredWeight`: Overrides the existing variant weights using the
    ///   `InitialVariantWeight` values in the `ProductionVariants` of
    ///   [CreateEndpointConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html).
    /// * `DataCaptureConfig`: (Not currently supported.)
    variant_property_type: VariantPropertyType,

    pub const json_field_names = .{
        .variant_property_type = "VariantPropertyType",
    };
};
