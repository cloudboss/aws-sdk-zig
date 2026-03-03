const std = @import("std");

pub const TransformationToolName = enum {
    app2_container,
    porting_assistant,
    emp,
    wwama,
    mgn,
    strategy_recommendation_support,
    in_place_os_upgrade,
    sct,
    dms,
    native_sql,

    pub const json_field_names = .{
        .app2_container = "App2Container",
        .porting_assistant = "Porting Assistant For .NET",
        .emp = "End of Support Migration",
        .wwama = "Windows Web Application Migration Assistant",
        .mgn = "Application Migration Service",
        .strategy_recommendation_support = "Strategy Recommendation Support",
        .in_place_os_upgrade = "In Place Operating System Upgrade",
        .sct = "Schema Conversion Tool",
        .dms = "Database Migration Service",
        .native_sql = "Native SQL Server Backup/Restore",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .app2_container => "App2Container",
            .porting_assistant => "Porting Assistant For .NET",
            .emp => "End of Support Migration",
            .wwama => "Windows Web Application Migration Assistant",
            .mgn => "Application Migration Service",
            .strategy_recommendation_support => "Strategy Recommendation Support",
            .in_place_os_upgrade => "In Place Operating System Upgrade",
            .sct => "Schema Conversion Tool",
            .dms => "Database Migration Service",
            .native_sql => "Native SQL Server Backup/Restore",
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
