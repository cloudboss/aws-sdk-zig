/// The
/// [traffic-shifting](https://docs.aws.amazon.com/lambda/latest/dg/lambda-traffic-shifting-using-aliases.html) configuration of a Lambda function alias.
pub const AliasRoutingConfiguration = struct {
    /// The second version, and the percentage of traffic that's routed to it.
    additional_version_weights: ?[]const u8,

    pub const json_field_names = .{
        .additional_version_weights = "AdditionalVersionWeights",
    };
};
