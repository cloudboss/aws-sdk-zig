/// Specify whether your DASH profile is on-demand or main. When you choose Main
/// profile, the service signals urn:mpeg:dash:profile:isoff-main:2011 in your
/// .mpd DASH manifest. When you choose On-demand, the service signals
/// urn:mpeg:dash:profile:isoff-on-demand:2011 in your .mpd. When you choose
/// On-demand, you must also set the output group setting Segment control to
/// Single file.
pub const DashIsoMpdProfile = enum {
    main_profile,
    on_demand_profile,

    pub const json_field_names = .{
        .main_profile = "MAIN_PROFILE",
        .on_demand_profile = "ON_DEMAND_PROFILE",
    };
};
