pub const StreamProcessorParameterToDelete = enum {
    connected_home_min_confidence,
    regions_of_interest,

    pub const json_field_names = .{
        .connected_home_min_confidence = "ConnectedHomeMinConfidence",
        .regions_of_interest = "RegionsOfInterest",
    };
};
