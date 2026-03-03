const std = @import("std");

pub const TestType = enum {
    builtin_fuzz,
    appium_java_junit,
    appium_java_testng,
    appium_python,
    appium_node,
    appium_ruby,
    appium_web_java_junit,
    appium_web_java_testng,
    appium_web_python,
    appium_web_node,
    appium_web_ruby,
    instrumentation,
    xctest,
    xctest_ui,

    pub const json_field_names = .{
        .builtin_fuzz = "BUILTIN_FUZZ",
        .appium_java_junit = "APPIUM_JAVA_JUNIT",
        .appium_java_testng = "APPIUM_JAVA_TESTNG",
        .appium_python = "APPIUM_PYTHON",
        .appium_node = "APPIUM_NODE",
        .appium_ruby = "APPIUM_RUBY",
        .appium_web_java_junit = "APPIUM_WEB_JAVA_JUNIT",
        .appium_web_java_testng = "APPIUM_WEB_JAVA_TESTNG",
        .appium_web_python = "APPIUM_WEB_PYTHON",
        .appium_web_node = "APPIUM_WEB_NODE",
        .appium_web_ruby = "APPIUM_WEB_RUBY",
        .instrumentation = "INSTRUMENTATION",
        .xctest = "XCTEST",
        .xctest_ui = "XCTEST_UI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .builtin_fuzz => "BUILTIN_FUZZ",
            .appium_java_junit => "APPIUM_JAVA_JUNIT",
            .appium_java_testng => "APPIUM_JAVA_TESTNG",
            .appium_python => "APPIUM_PYTHON",
            .appium_node => "APPIUM_NODE",
            .appium_ruby => "APPIUM_RUBY",
            .appium_web_java_junit => "APPIUM_WEB_JAVA_JUNIT",
            .appium_web_java_testng => "APPIUM_WEB_JAVA_TESTNG",
            .appium_web_python => "APPIUM_WEB_PYTHON",
            .appium_web_node => "APPIUM_WEB_NODE",
            .appium_web_ruby => "APPIUM_WEB_RUBY",
            .instrumentation => "INSTRUMENTATION",
            .xctest => "XCTEST",
            .xctest_ui => "XCTEST_UI",
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
