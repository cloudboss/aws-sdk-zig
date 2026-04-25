const std = @import("std");

pub const StreamClass = enum {
    gen_4_n_high,
    gen_4_n_ultra,
    gen_4_n_win_2022,
    gen_5_n_high,
    gen_5_n_ultra,
    gen_5_n_win_2022,
    gen_6_n_small,
    gen_6_n_medium,
    gen_6_n_high,
    gen_6_n_ultra,
    gen_6_n_ultra_win_2022,
    gen_6_n_pro,
    gen_6_n_pro_win_2022,
    gen_6_n_small_win_2022,
    gen_6_n_medium_win_2022,
    gen_6_e_pro,
    gen_6_e_pro_win_2022,

    pub const json_field_names = .{
        .gen_4_n_high = "gen4n_high",
        .gen_4_n_ultra = "gen4n_ultra",
        .gen_4_n_win_2022 = "gen4n_win2022",
        .gen_5_n_high = "gen5n_high",
        .gen_5_n_ultra = "gen5n_ultra",
        .gen_5_n_win_2022 = "gen5n_win2022",
        .gen_6_n_small = "gen6n_small",
        .gen_6_n_medium = "gen6n_medium",
        .gen_6_n_high = "gen6n_high",
        .gen_6_n_ultra = "gen6n_ultra",
        .gen_6_n_ultra_win_2022 = "gen6n_ultra_win2022",
        .gen_6_n_pro = "gen6n_pro",
        .gen_6_n_pro_win_2022 = "gen6n_pro_win2022",
        .gen_6_n_small_win_2022 = "gen6n_small_win2022",
        .gen_6_n_medium_win_2022 = "gen6n_medium_win2022",
        .gen_6_e_pro = "gen6e_pro",
        .gen_6_e_pro_win_2022 = "gen6e_pro_win2022",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gen_4_n_high => "gen4n_high",
            .gen_4_n_ultra => "gen4n_ultra",
            .gen_4_n_win_2022 => "gen4n_win2022",
            .gen_5_n_high => "gen5n_high",
            .gen_5_n_ultra => "gen5n_ultra",
            .gen_5_n_win_2022 => "gen5n_win2022",
            .gen_6_n_small => "gen6n_small",
            .gen_6_n_medium => "gen6n_medium",
            .gen_6_n_high => "gen6n_high",
            .gen_6_n_ultra => "gen6n_ultra",
            .gen_6_n_ultra_win_2022 => "gen6n_ultra_win2022",
            .gen_6_n_pro => "gen6n_pro",
            .gen_6_n_pro_win_2022 => "gen6n_pro_win2022",
            .gen_6_n_small_win_2022 => "gen6n_small_win2022",
            .gen_6_n_medium_win_2022 => "gen6n_medium_win2022",
            .gen_6_e_pro => "gen6e_pro",
            .gen_6_e_pro_win_2022 => "gen6e_pro_win2022",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
