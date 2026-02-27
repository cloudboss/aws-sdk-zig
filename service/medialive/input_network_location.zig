/// With the introduction of MediaLive Anywhere, a MediaLive input can now exist
/// in two different places: AWS or
/// inside an on-premises datacenter. By default all inputs will continue to be
/// AWS inputs.
pub const InputNetworkLocation = enum {
    aws,
    on_premises,

    pub const json_field_names = .{
        .aws = "AWS",
        .on_premises = "ON_PREMISES",
    };
};
