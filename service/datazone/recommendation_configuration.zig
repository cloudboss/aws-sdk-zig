/// The recommendation to be updated as part of the `UpdateDataSource` action.
pub const RecommendationConfiguration = struct {
    /// Specifies whether automatic business name generation is to be enabled or not
    /// as part of the recommendation configuration.
    enable_business_name_generation: ?bool,

    pub const json_field_names = .{
        .enable_business_name_generation = "enableBusinessNameGeneration",
    };
};
