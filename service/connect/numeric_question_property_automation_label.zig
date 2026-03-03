const std = @import("std");

pub const NumericQuestionPropertyAutomationLabel = enum {
    overall_customer_sentiment_score,
    overall_agent_sentiment_score,
    customer_sentiment_score_without_agent,
    customer_sentiment_score_with_agent,
    non_talk_time,
    non_talk_time_percentage,
    number_of_interruptions,
    contact_duration,
    agent_interaction_duration,
    customer_hold_time,
    longest_hold_duration,
    number_of_holds,
    agent_interaction_and_hold_duration,

    pub const json_field_names = .{
        .overall_customer_sentiment_score = "OVERALL_CUSTOMER_SENTIMENT_SCORE",
        .overall_agent_sentiment_score = "OVERALL_AGENT_SENTIMENT_SCORE",
        .customer_sentiment_score_without_agent = "CUSTOMER_SENTIMENT_SCORE_WITHOUT_AGENT",
        .customer_sentiment_score_with_agent = "CUSTOMER_SENTIMENT_SCORE_WITH_AGENT",
        .non_talk_time = "NON_TALK_TIME",
        .non_talk_time_percentage = "NON_TALK_TIME_PERCENTAGE",
        .number_of_interruptions = "NUMBER_OF_INTERRUPTIONS",
        .contact_duration = "CONTACT_DURATION",
        .agent_interaction_duration = "AGENT_INTERACTION_DURATION",
        .customer_hold_time = "CUSTOMER_HOLD_TIME",
        .longest_hold_duration = "LONGEST_HOLD_DURATION",
        .number_of_holds = "NUMBER_OF_HOLDS",
        .agent_interaction_and_hold_duration = "AGENT_INTERACTION_AND_HOLD_DURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .overall_customer_sentiment_score => "OVERALL_CUSTOMER_SENTIMENT_SCORE",
            .overall_agent_sentiment_score => "OVERALL_AGENT_SENTIMENT_SCORE",
            .customer_sentiment_score_without_agent => "CUSTOMER_SENTIMENT_SCORE_WITHOUT_AGENT",
            .customer_sentiment_score_with_agent => "CUSTOMER_SENTIMENT_SCORE_WITH_AGENT",
            .non_talk_time => "NON_TALK_TIME",
            .non_talk_time_percentage => "NON_TALK_TIME_PERCENTAGE",
            .number_of_interruptions => "NUMBER_OF_INTERRUPTIONS",
            .contact_duration => "CONTACT_DURATION",
            .agent_interaction_duration => "AGENT_INTERACTION_DURATION",
            .customer_hold_time => "CUSTOMER_HOLD_TIME",
            .longest_hold_duration => "LONGEST_HOLD_DURATION",
            .number_of_holds => "NUMBER_OF_HOLDS",
            .agent_interaction_and_hold_duration => "AGENT_INTERACTION_AND_HOLD_DURATION",
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
