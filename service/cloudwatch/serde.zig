const aws = @import("aws");
const std = @import("std");

const ActionsSuppressedBy = @import("actions_suppressed_by.zig").ActionsSuppressedBy;
const AlarmContributor = @import("alarm_contributor.zig").AlarmContributor;
const AlarmHistoryItem = @import("alarm_history_item.zig").AlarmHistoryItem;
const AlarmMuteRuleStatus = @import("alarm_mute_rule_status.zig").AlarmMuteRuleStatus;
const AlarmMuteRuleSummary = @import("alarm_mute_rule_summary.zig").AlarmMuteRuleSummary;
const AlarmType = @import("alarm_type.zig").AlarmType;
const AnomalyDetector = @import("anomaly_detector.zig").AnomalyDetector;
const AnomalyDetectorConfiguration = @import("anomaly_detector_configuration.zig").AnomalyDetectorConfiguration;
const AnomalyDetectorStateValue = @import("anomaly_detector_state_value.zig").AnomalyDetectorStateValue;
const AnomalyDetectorType = @import("anomaly_detector_type.zig").AnomalyDetectorType;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const CompositeAlarm = @import("composite_alarm.zig").CompositeAlarm;
const DashboardEntry = @import("dashboard_entry.zig").DashboardEntry;
const DashboardValidationMessage = @import("dashboard_validation_message.zig").DashboardValidationMessage;
const Datapoint = @import("datapoint.zig").Datapoint;
const Dimension = @import("dimension.zig").Dimension;
const DimensionFilter = @import("dimension_filter.zig").DimensionFilter;
const Entity = @import("entity.zig").Entity;
const EntityMetricData = @import("entity_metric_data.zig").EntityMetricData;
const EvaluationState = @import("evaluation_state.zig").EvaluationState;
const HistoryItemType = @import("history_item_type.zig").HistoryItemType;
const InsightRule = @import("insight_rule.zig").InsightRule;
const InsightRuleContributor = @import("insight_rule_contributor.zig").InsightRuleContributor;
const InsightRuleContributorDatapoint = @import("insight_rule_contributor_datapoint.zig").InsightRuleContributorDatapoint;
const InsightRuleMetricDatapoint = @import("insight_rule_metric_datapoint.zig").InsightRuleMetricDatapoint;
const LabelOptions = @import("label_options.zig").LabelOptions;
const ManagedRule = @import("managed_rule.zig").ManagedRule;
const ManagedRuleDescription = @import("managed_rule_description.zig").ManagedRuleDescription;
const ManagedRuleState = @import("managed_rule_state.zig").ManagedRuleState;
const MessageData = @import("message_data.zig").MessageData;
const Metric = @import("metric.zig").Metric;
const MetricAlarm = @import("metric_alarm.zig").MetricAlarm;
const MetricCharacteristics = @import("metric_characteristics.zig").MetricCharacteristics;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const MetricDataResult = @import("metric_data_result.zig").MetricDataResult;
const MetricDatum = @import("metric_datum.zig").MetricDatum;
const MetricMathAnomalyDetector = @import("metric_math_anomaly_detector.zig").MetricMathAnomalyDetector;
const MetricStat = @import("metric_stat.zig").MetricStat;
const MetricStreamEntry = @import("metric_stream_entry.zig").MetricStreamEntry;
const MetricStreamFilter = @import("metric_stream_filter.zig").MetricStreamFilter;
const MetricStreamOutputFormat = @import("metric_stream_output_format.zig").MetricStreamOutputFormat;
const MetricStreamStatisticsConfiguration = @import("metric_stream_statistics_configuration.zig").MetricStreamStatisticsConfiguration;
const MetricStreamStatisticsMetric = @import("metric_stream_statistics_metric.zig").MetricStreamStatisticsMetric;
const MuteTargets = @import("mute_targets.zig").MuteTargets;
const PartialFailure = @import("partial_failure.zig").PartialFailure;
const Range = @import("range.zig").Range;
const Rule = @import("rule.zig").Rule;
const Schedule = @import("schedule.zig").Schedule;
const SingleMetricAnomalyDetector = @import("single_metric_anomaly_detector.zig").SingleMetricAnomalyDetector;
const StandardUnit = @import("standard_unit.zig").StandardUnit;
const StateValue = @import("state_value.zig").StateValue;
const Statistic = @import("statistic.zig").Statistic;
const StatisticSet = @import("statistic_set.zig").StatisticSet;
const StatusCode = @import("status_code.zig").StatusCode;
const Tag = @import("tag.zig").Tag;

pub fn deserializeAlarmContributors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AlarmContributor {
    var list: std.ArrayList(AlarmContributor) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAlarmContributor(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAlarmHistoryItems(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AlarmHistoryItem {
    var list: std.ArrayList(AlarmHistoryItem) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAlarmHistoryItem(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAlarmMuteRuleSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AlarmMuteRuleSummary {
    var list: std.ArrayList(AlarmMuteRuleSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAlarmMuteRuleSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAnomalyDetectorExcludedTimeRanges(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Range {
    var list: std.ArrayList(Range) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRange(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAnomalyDetectors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AnomalyDetector {
    var list: std.ArrayList(AnomalyDetector) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAnomalyDetector(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBatchFailures(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PartialFailure {
    var list: std.ArrayList(PartialFailure) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePartialFailure(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCompositeAlarms(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const CompositeAlarm {
    var list: std.ArrayList(CompositeAlarm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeCompositeAlarm(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDashboardEntries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DashboardEntry {
    var list: std.ArrayList(DashboardEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDashboardEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDashboardValidationMessages(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DashboardValidationMessage {
    var list: std.ArrayList(DashboardValidationMessage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDashboardValidationMessage(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDatapointValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const f64 {
    var list: std.ArrayList(f64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseFloat(f64, try reader.readElementText()) catch null) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDatapoints(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Datapoint {
    var list: std.ArrayList(Datapoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDatapoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDimensions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Dimension {
    var list: std.ArrayList(Dimension) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDimension(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInsightRuleContributorDatapoints(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InsightRuleContributorDatapoint {
    var list: std.ArrayList(InsightRuleContributorDatapoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInsightRuleContributorDatapoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInsightRuleContributorKeyLabels(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInsightRuleContributorKeys(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInsightRuleContributors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InsightRuleContributor {
    var list: std.ArrayList(InsightRuleContributor) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInsightRuleContributor(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInsightRuleMetricDatapoints(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InsightRuleMetricDatapoint {
    var list: std.ArrayList(InsightRuleMetricDatapoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInsightRuleMetricDatapoint(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeInsightRules(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InsightRule {
    var list: std.ArrayList(InsightRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInsightRule(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeManagedRuleDescriptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ManagedRuleDescription {
    var list: std.ArrayList(ManagedRuleDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeManagedRuleDescription(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricAlarms(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricAlarm {
    var list: std.ArrayList(MetricAlarm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricAlarm(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricDataQueries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricDataQuery {
    var list: std.ArrayList(MetricDataQuery) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricDataQuery(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricDataResultMessages(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MessageData {
    var list: std.ArrayList(MessageData) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMessageData(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricDataResults(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricDataResult {
    var list: std.ArrayList(MetricDataResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricDataResult(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricStreamEntries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricStreamEntry {
    var list: std.ArrayList(MetricStreamEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricStreamEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricStreamFilterMetricNames(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricStreamFilters(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricStreamFilter {
    var list: std.ArrayList(MetricStreamFilter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricStreamFilter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricStreamStatisticsAdditionalStatistics(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricStreamStatisticsConfigurations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricStreamStatisticsConfiguration {
    var list: std.ArrayList(MetricStreamStatisticsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricStreamStatisticsConfiguration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetricStreamStatisticsIncludeMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MetricStreamStatisticsMetric {
    var list: std.ArrayList(MetricStreamStatisticsMetric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetricStreamStatisticsMetric(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMetrics(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Metric {
    var list: std.ArrayList(Metric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMetric(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeMuteTargetAlarmNameList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOwningAccounts(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTagList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTimestamps(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i64 {
    var list: std.ArrayList(i64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (aws.date.parseIso8601(try reader.readElementText()) catch null) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeContributorAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
    var list: std.ArrayList(aws.map.StringMapEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: []const u8 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeDatapointValueMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(f64) {
    var list: std.ArrayList(aws.map.MapEntry(f64)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: f64 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch 0;
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAlarmContributor(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AlarmContributor {
    var result: AlarmContributor = undefined;
    result.state_transitioned_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContributorAttributes")) {
                    result.contributor_attributes = try deserializeContributorAttributes(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "ContributorId")) {
                    result.contributor_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateReason")) {
                    result.state_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateTransitionedTimestamp")) {
                    result.state_transitioned_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAlarmHistoryItem(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AlarmHistoryItem {
    var result: AlarmHistoryItem = undefined;
    result.alarm_contributor_attributes = null;
    result.alarm_contributor_id = null;
    result.alarm_name = null;
    result.alarm_type = null;
    result.history_data = null;
    result.history_item_type = null;
    result.history_summary = null;
    result.timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmContributorAttributes")) {
                    result.alarm_contributor_attributes = try deserializeContributorAttributes(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "AlarmContributorId")) {
                    result.alarm_contributor_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmType")) {
                    result.alarm_type = AlarmType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HistoryData")) {
                    result.history_data = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HistoryItemType")) {
                    result.history_item_type = HistoryItemType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HistorySummary")) {
                    result.history_summary = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAlarmMuteRuleSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AlarmMuteRuleSummary {
    var result: AlarmMuteRuleSummary = undefined;
    result.alarm_mute_rule_arn = null;
    result.expire_date = null;
    result.last_updated_timestamp = null;
    result.mute_type = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmMuteRuleArn")) {
                    result.alarm_mute_rule_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpireDate")) {
                    result.expire_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTimestamp")) {
                    result.last_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MuteType")) {
                    result.mute_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = AlarmMuteRuleStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnomalyDetector(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnomalyDetector {
    var result: AnomalyDetector = undefined;
    result.configuration = null;
    result.dimensions = null;
    result.metric_characteristics = null;
    result.metric_math_anomaly_detector = null;
    result.metric_name = null;
    result.namespace = null;
    result.single_metric_anomaly_detector = null;
    result.stat = null;
    result.state_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Configuration")) {
                    result.configuration = try deserializeAnomalyDetectorConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricCharacteristics")) {
                    result.metric_characteristics = try deserializeMetricCharacteristics(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MetricMathAnomalyDetector")) {
                    result.metric_math_anomaly_detector = try deserializeMetricMathAnomalyDetector(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SingleMetricAnomalyDetector")) {
                    result.single_metric_anomaly_detector = try deserializeSingleMetricAnomalyDetector(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateValue")) {
                    result.state_value = AnomalyDetectorStateValue.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnomalyDetectorConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnomalyDetectorConfiguration {
    var result: AnomalyDetectorConfiguration = undefined;
    result.excluded_time_ranges = null;
    result.metric_timezone = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExcludedTimeRanges")) {
                    result.excluded_time_ranges = try deserializeAnomalyDetectorExcludedTimeRanges(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricTimezone")) {
                    result.metric_timezone = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCompositeAlarm(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !CompositeAlarm {
    var result: CompositeAlarm = undefined;
    result.actions_enabled = null;
    result.actions_suppressed_by = null;
    result.actions_suppressed_reason = null;
    result.actions_suppressor = null;
    result.actions_suppressor_extension_period = null;
    result.actions_suppressor_wait_period = null;
    result.alarm_actions = null;
    result.alarm_arn = null;
    result.alarm_configuration_updated_timestamp = null;
    result.alarm_description = null;
    result.alarm_name = null;
    result.alarm_rule = null;
    result.insufficient_data_actions = null;
    result.ok_actions = null;
    result.state_reason = null;
    result.state_reason_data = null;
    result.state_transitioned_timestamp = null;
    result.state_updated_timestamp = null;
    result.state_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionsEnabled")) {
                    result.actions_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressedBy")) {
                    result.actions_suppressed_by = ActionsSuppressedBy.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressedReason")) {
                    result.actions_suppressed_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressor")) {
                    result.actions_suppressor = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressorExtensionPeriod")) {
                    result.actions_suppressor_extension_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressorWaitPeriod")) {
                    result.actions_suppressor_wait_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AlarmActions")) {
                    result.alarm_actions = try deserializeResourceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AlarmArn")) {
                    result.alarm_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmConfigurationUpdatedTimestamp")) {
                    result.alarm_configuration_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AlarmDescription")) {
                    result.alarm_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmRule")) {
                    result.alarm_rule = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InsufficientDataActions")) {
                    result.insufficient_data_actions = try deserializeResourceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "OKActions")) {
                    result.ok_actions = try deserializeResourceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "StateReason")) {
                    result.state_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateReasonData")) {
                    result.state_reason_data = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateTransitionedTimestamp")) {
                    result.state_transitioned_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateUpdatedTimestamp")) {
                    result.state_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateValue")) {
                    result.state_value = StateValue.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDashboardEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DashboardEntry {
    var result: DashboardEntry = undefined;
    result.dashboard_arn = null;
    result.dashboard_name = null;
    result.last_modified = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DashboardArn")) {
                    result.dashboard_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DashboardName")) {
                    result.dashboard_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDashboardValidationMessage(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DashboardValidationMessage {
    var result: DashboardValidationMessage = undefined;
    result.data_path = null;
    result.message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataPath")) {
                    result.data_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDatapoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Datapoint {
    var result: Datapoint = undefined;
    result.average = null;
    result.extended_statistics = null;
    result.maximum = null;
    result.minimum = null;
    result.sample_count = null;
    result.sum = null;
    result.timestamp = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Average")) {
                    result.average = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExtendedStatistics")) {
                    result.extended_statistics = try deserializeDatapointValueMap(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Minimum")) {
                    result.minimum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SampleCount")) {
                    result.sample_count = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Sum")) {
                    result.sum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = StandardUnit.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDimension(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Dimension {
    var result: Dimension = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InsightRule {
    var result: InsightRule = undefined;
    result.apply_on_transformed_logs = null;
    result.managed_rule = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyOnTransformedLogs")) {
                    result.apply_on_transformed_logs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Definition")) {
                    result.definition = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManagedRule")) {
                    result.managed_rule = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Schema")) {
                    result.schema = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRuleContributor(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InsightRuleContributor {
    var result: InsightRuleContributor = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApproximateAggregateValue")) {
                    result.approximate_aggregate_value = try std.fmt.parseFloat(f64, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Datapoints")) {
                    result.datapoints = try deserializeInsightRuleContributorDatapoints(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Keys")) {
                    result.keys = try deserializeInsightRuleContributorKeys(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRuleContributorDatapoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InsightRuleContributorDatapoint {
    _ = allocator;
    var result: InsightRuleContributorDatapoint = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApproximateValue")) {
                    result.approximate_value = try std.fmt.parseFloat(f64, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRuleMetricDatapoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InsightRuleMetricDatapoint {
    _ = allocator;
    var result: InsightRuleMetricDatapoint = undefined;
    result.average = null;
    result.max_contributor_value = null;
    result.maximum = null;
    result.minimum = null;
    result.sample_count = null;
    result.sum = null;
    result.unique_contributors = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Average")) {
                    result.average = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxContributorValue")) {
                    result.max_contributor_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Minimum")) {
                    result.minimum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SampleCount")) {
                    result.sample_count = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Sum")) {
                    result.sum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UniqueContributors")) {
                    result.unique_contributors = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedRuleDescription(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedRuleDescription {
    var result: ManagedRuleDescription = undefined;
    result.resource_arn = null;
    result.rule_state = null;
    result.template_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceARN")) {
                    result.resource_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RuleState")) {
                    result.rule_state = try deserializeManagedRuleState(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedRuleState(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedRuleState {
    var result: ManagedRuleState = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RuleName")) {
                    result.rule_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMessageData(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MessageData {
    var result: MessageData = undefined;
    result.code = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Metric {
    var result: Metric = undefined;
    result.dimensions = null;
    result.metric_name = null;
    result.namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricAlarm(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricAlarm {
    var result: MetricAlarm = undefined;
    result.actions_enabled = null;
    result.alarm_actions = null;
    result.alarm_arn = null;
    result.alarm_configuration_updated_timestamp = null;
    result.alarm_description = null;
    result.alarm_name = null;
    result.comparison_operator = null;
    result.datapoints_to_alarm = null;
    result.dimensions = null;
    result.evaluate_low_sample_count_percentile = null;
    result.evaluation_criteria = null;
    result.evaluation_interval = null;
    result.evaluation_periods = null;
    result.evaluation_state = null;
    result.extended_statistic = null;
    result.insufficient_data_actions = null;
    result.metric_name = null;
    result.metrics = null;
    result.namespace = null;
    result.ok_actions = null;
    result.period = null;
    result.state_reason = null;
    result.state_reason_data = null;
    result.state_transitioned_timestamp = null;
    result.state_updated_timestamp = null;
    result.state_value = null;
    result.statistic = null;
    result.threshold = null;
    result.threshold_metric_id = null;
    result.treat_missing_data = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionsEnabled")) {
                    result.actions_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AlarmActions")) {
                    result.alarm_actions = try deserializeResourceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AlarmArn")) {
                    result.alarm_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmConfigurationUpdatedTimestamp")) {
                    result.alarm_configuration_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AlarmDescription")) {
                    result.alarm_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ComparisonOperator")) {
                    result.comparison_operator = ComparisonOperator.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatapointsToAlarm")) {
                    result.datapoints_to_alarm = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "EvaluateLowSampleCountPercentile")) {
                    result.evaluate_low_sample_count_percentile = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvaluationCriteria")) {
                    try reader.skipElement();
                } else if (std.mem.eql(u8, e.local, "EvaluationInterval")) {
                    result.evaluation_interval = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EvaluationPeriods")) {
                    result.evaluation_periods = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EvaluationState")) {
                    result.evaluation_state = EvaluationState.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExtendedStatistic")) {
                    result.extended_statistic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InsufficientDataActions")) {
                    result.insufficient_data_actions = try deserializeResourceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeMetricDataQueries(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OKActions")) {
                    result.ok_actions = try deserializeResourceList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StateReason")) {
                    result.state_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateReasonData")) {
                    result.state_reason_data = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateTransitionedTimestamp")) {
                    result.state_transitioned_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateUpdatedTimestamp")) {
                    result.state_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateValue")) {
                    result.state_value = StateValue.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Statistic")) {
                    result.statistic = Statistic.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Threshold")) {
                    result.threshold = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ThresholdMetricId")) {
                    result.threshold_metric_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TreatMissingData")) {
                    result.treat_missing_data = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = StandardUnit.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricCharacteristics(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricCharacteristics {
    _ = allocator;
    var result: MetricCharacteristics = undefined;
    result.periodic_spikes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PeriodicSpikes")) {
                    result.periodic_spikes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricDataQuery(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricDataQuery {
    var result: MetricDataQuery = undefined;
    result.account_id = null;
    result.expression = null;
    result.label = null;
    result.metric_stat = null;
    result.period = null;
    result.return_data = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expression")) {
                    result.expression = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetricStat")) {
                    result.metric_stat = try deserializeMetricStat(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ReturnData")) {
                    result.return_data = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricDataResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricDataResult {
    var result: MetricDataResult = undefined;
    result.id = null;
    result.label = null;
    result.messages = null;
    result.status_code = null;
    result.timestamps = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Messages")) {
                    result.messages = try deserializeMetricDataResultMessages(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = StatusCode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamps")) {
                    result.timestamps = try deserializeTimestamps(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeDatapointValues(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricMathAnomalyDetector(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricMathAnomalyDetector {
    var result: MetricMathAnomalyDetector = undefined;
    result.metric_data_queries = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStat(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricStat {
    var result: MetricStat = undefined;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try deserializeMetric(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = StandardUnit.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricStreamEntry {
    var result: MetricStreamEntry = undefined;
    result.arn = null;
    result.creation_date = null;
    result.firehose_arn = null;
    result.last_update_date = null;
    result.name = null;
    result.output_format = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FirehoseArn")) {
                    result.firehose_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastUpdateDate")) {
                    result.last_update_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputFormat")) {
                    result.output_format = MetricStreamOutputFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricStreamFilter {
    var result: MetricStreamFilter = undefined;
    result.metric_names = null;
    result.namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricNames")) {
                    result.metric_names = try deserializeMetricStreamFilterMetricNames(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamStatisticsConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricStreamStatisticsConfiguration {
    var result: MetricStreamStatisticsConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStatistics")) {
                    result.additional_statistics = try deserializeMetricStreamStatisticsAdditionalStatistics(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "IncludeMetrics")) {
                    result.include_metrics = try deserializeMetricStreamStatisticsIncludeMetrics(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamStatisticsMetric(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MetricStreamStatisticsMetric {
    var result: MetricStreamStatisticsMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMuteTargets(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MuteTargets {
    var result: MuteTargets = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmNames")) {
                    result.alarm_names = try deserializeMuteTargetAlarmNameList(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePartialFailure(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PartialFailure {
    var result: PartialFailure = undefined;
    result.exception_type = null;
    result.failure_code = null;
    result.failure_description = null;
    result.failure_resource = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExceptionType")) {
                    result.exception_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureCode")) {
                    result.failure_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureDescription")) {
                    result.failure_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureResource")) {
                    result.failure_resource = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Range {
    _ = allocator;
    var result: Range = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Rule {
    var result: Rule = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Schedule")) {
                    result.schedule = try deserializeSchedule(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSchedule(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Schedule {
    var result: Schedule = undefined;
    result.timezone = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Duration")) {
                    result.duration = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expression")) {
                    result.expression = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timezone")) {
                    result.timezone = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSingleMetricAnomalyDetector(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SingleMetricAnomalyDetector {
    var result: SingleMetricAnomalyDetector = undefined;
    result.account_id = null;
    result.dimensions = null;
    result.metric_name = null;
    result.namespace = null;
    result.stat = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAlarmMuteRuleStatuses(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AlarmMuteRuleStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAlarmNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAlarmTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AlarmType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAnomalyDetectorExcludedTimeRanges(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Range, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRange(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAnomalyDetectorTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AnomalyDetectorType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCounts(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const f64, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{item}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDashboardNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDimensionFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DimensionFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeDimensionFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeDimensions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Dimension, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeDimension(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEntityMetricDataList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EntityMetricData, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeEntityMetricData(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeExtendedStatistics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeInsightRuleMetricList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeInsightRuleNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeManagedRules(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ManagedRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeManagedRule(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricData(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDatum, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricDatum(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricDataQueries(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDataQuery, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricDataQuery(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricStreamFilterMetricNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricStreamFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricStreamFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricStreamFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricStreamNames(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricStreamStatisticsAdditionalStatistics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricStreamStatisticsConfigurations(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricStreamStatisticsConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricStreamStatisticsConfiguration(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMetricStreamStatisticsIncludeMetrics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricStreamStatisticsMetric, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeMetricStreamStatisticsMetric(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeMuteTargetAlarmNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStatistics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Statistic, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagKeyList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTagList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeValues(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const f64, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{item}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEntityAttributesMap(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeEntityKeyAttributesMap(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAnomalyDetectorConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnomalyDetectorConfiguration) !void {
    if (value.excluded_time_ranges) |v| {
        try buf.appendSlice(allocator, "<ExcludedTimeRanges>");
        try serializeAnomalyDetectorExcludedTimeRanges(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ExcludedTimeRanges>");
    }
    if (value.metric_timezone) |v| {
        try buf.appendSlice(allocator, "<MetricTimezone>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricTimezone>");
    }
}

pub fn serializeDimension(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Dimension) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeDimensionFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DimensionFilter) !void {
    try buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.name);
    try buf.appendSlice(allocator, "</Name>");
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Value>");
    }
}

pub fn serializeEntity(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Entity) !void {
    if (value.attributes) |v| {
        try buf.appendSlice(allocator, "<Attributes>");
        try serializeEntityAttributesMap(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</Attributes>");
    }
    if (value.key_attributes) |v| {
        try buf.appendSlice(allocator, "<KeyAttributes>");
        try serializeEntityKeyAttributesMap(allocator, buf, v, "entry");
        try buf.appendSlice(allocator, "</KeyAttributes>");
    }
}

pub fn serializeEntityMetricData(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EntityMetricData) !void {
    if (value.entity) |v| {
        try buf.appendSlice(allocator, "<Entity>");
        try serializeEntity(allocator, buf, v);
        try buf.appendSlice(allocator, "</Entity>");
    }
    if (value.metric_data) |v| {
        try buf.appendSlice(allocator, "<MetricData>");
        try serializeMetricData(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</MetricData>");
    }
}

pub fn serializeLabelOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LabelOptions) !void {
    if (value.timezone) |v| {
        try buf.appendSlice(allocator, "<Timezone>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Timezone>");
    }
}

pub fn serializeManagedRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ManagedRule) !void {
    try buf.appendSlice(allocator, "<ResourceARN>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.resource_arn);
    try buf.appendSlice(allocator, "</ResourceARN>");
    if (value.tags) |v| {
        try buf.appendSlice(allocator, "<Tags>");
        try serializeTagList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Tags>");
    }
    try buf.appendSlice(allocator, "<TemplateName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.template_name);
    try buf.appendSlice(allocator, "</TemplateName>");
}

pub fn serializeMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Metric) !void {
    if (value.dimensions) |v| {
        try buf.appendSlice(allocator, "<Dimensions>");
        try serializeDimensions(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Dimensions>");
    }
    if (value.metric_name) |v| {
        try buf.appendSlice(allocator, "<MetricName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricName>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(allocator, "<Namespace>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Namespace>");
    }
}

pub fn serializeMetricCharacteristics(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricCharacteristics) !void {
    if (value.periodic_spikes) |v| {
        try buf.appendSlice(allocator, "<PeriodicSpikes>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</PeriodicSpikes>");
    }
}

pub fn serializeMetricDataQuery(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDataQuery) !void {
    if (value.account_id) |v| {
        try buf.appendSlice(allocator, "<AccountId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccountId>");
    }
    if (value.expression) |v| {
        try buf.appendSlice(allocator, "<Expression>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Expression>");
    }
    try buf.appendSlice(allocator, "<Id>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.id);
    try buf.appendSlice(allocator, "</Id>");
    if (value.label) |v| {
        try buf.appendSlice(allocator, "<Label>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Label>");
    }
    if (value.metric_stat) |v| {
        try buf.appendSlice(allocator, "<MetricStat>");
        try serializeMetricStat(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricStat>");
    }
    if (value.period) |v| {
        try buf.appendSlice(allocator, "<Period>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Period>");
    }
    if (value.return_data) |v| {
        try buf.appendSlice(allocator, "<ReturnData>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnData>");
    }
}

pub fn serializeMetricDatum(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDatum) !void {
    if (value.counts) |v| {
        try buf.appendSlice(allocator, "<Counts>");
        try serializeCounts(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Counts>");
    }
    if (value.dimensions) |v| {
        try buf.appendSlice(allocator, "<Dimensions>");
        try serializeDimensions(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Dimensions>");
    }
    try buf.appendSlice(allocator, "<MetricName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.metric_name);
    try buf.appendSlice(allocator, "</MetricName>");
    if (value.statistic_values) |v| {
        try buf.appendSlice(allocator, "<StatisticValues>");
        try serializeStatisticSet(allocator, buf, v);
        try buf.appendSlice(allocator, "</StatisticValues>");
    }
    if (value.storage_resolution) |v| {
        try buf.appendSlice(allocator, "<StorageResolution>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</StorageResolution>");
    }
    if (value.timestamp) |v| {
        try buf.appendSlice(allocator, "<Timestamp>");
        {
            const ts_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, ts_str);
        }
        try buf.appendSlice(allocator, "</Timestamp>");
    }
    if (value.unit) |v| {
        try buf.appendSlice(allocator, "<Unit>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Unit>");
    }
    if (value.value) |v| {
        try buf.appendSlice(allocator, "<Value>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</Value>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializeValues(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeMetricMathAnomalyDetector(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricMathAnomalyDetector) !void {
    if (value.metric_data_queries) |v| {
        try buf.appendSlice(allocator, "<MetricDataQueries>");
        try serializeMetricDataQueries(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</MetricDataQueries>");
    }
}

pub fn serializeMetricStat(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStat) !void {
    try buf.appendSlice(allocator, "<Metric>");
    try serializeMetric(allocator, buf, value.metric);
    try buf.appendSlice(allocator, "</Metric>");
    try buf.appendSlice(allocator, "<Period>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.period}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Period>");
    try buf.appendSlice(allocator, "<Stat>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.stat);
    try buf.appendSlice(allocator, "</Stat>");
    if (value.unit) |v| {
        try buf.appendSlice(allocator, "<Unit>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Unit>");
    }
}

pub fn serializeMetricStreamFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStreamFilter) !void {
    if (value.metric_names) |v| {
        try buf.appendSlice(allocator, "<MetricNames>");
        try serializeMetricStreamFilterMetricNames(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</MetricNames>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(allocator, "<Namespace>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Namespace>");
    }
}

pub fn serializeMetricStreamStatisticsConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStreamStatisticsConfiguration) !void {
    try buf.appendSlice(allocator, "<AdditionalStatistics>");
    try serializeMetricStreamStatisticsAdditionalStatistics(allocator, buf, value.additional_statistics, "member");
    try buf.appendSlice(allocator, "</AdditionalStatistics>");
    try buf.appendSlice(allocator, "<IncludeMetrics>");
    try serializeMetricStreamStatisticsIncludeMetrics(allocator, buf, value.include_metrics, "member");
    try buf.appendSlice(allocator, "</IncludeMetrics>");
}

pub fn serializeMetricStreamStatisticsMetric(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStreamStatisticsMetric) !void {
    try buf.appendSlice(allocator, "<MetricName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.metric_name);
    try buf.appendSlice(allocator, "</MetricName>");
    try buf.appendSlice(allocator, "<Namespace>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.namespace);
    try buf.appendSlice(allocator, "</Namespace>");
}

pub fn serializeMuteTargets(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: MuteTargets) !void {
    try buf.appendSlice(allocator, "<AlarmNames>");
    try serializeMuteTargetAlarmNameList(allocator, buf, value.alarm_names, "member");
    try buf.appendSlice(allocator, "</AlarmNames>");
}

pub fn serializeRange(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Range) !void {
    try buf.appendSlice(allocator, "<EndTime>");
    {
        const ts_str = std.fmt.allocPrint(allocator, "{d}", .{value.end_time}) catch "";
        try buf.appendSlice(allocator, ts_str);
    }
    try buf.appendSlice(allocator, "</EndTime>");
    try buf.appendSlice(allocator, "<StartTime>");
    {
        const ts_str = std.fmt.allocPrint(allocator, "{d}", .{value.start_time}) catch "";
        try buf.appendSlice(allocator, ts_str);
    }
    try buf.appendSlice(allocator, "</StartTime>");
}

pub fn serializeRule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Rule) !void {
    try buf.appendSlice(allocator, "<Schedule>");
    try serializeSchedule(allocator, buf, value.schedule);
    try buf.appendSlice(allocator, "</Schedule>");
}

pub fn serializeSchedule(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Schedule) !void {
    try buf.appendSlice(allocator, "<Duration>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.duration);
    try buf.appendSlice(allocator, "</Duration>");
    try buf.appendSlice(allocator, "<Expression>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.expression);
    try buf.appendSlice(allocator, "</Expression>");
    if (value.timezone) |v| {
        try buf.appendSlice(allocator, "<Timezone>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Timezone>");
    }
}

pub fn serializeSingleMetricAnomalyDetector(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: SingleMetricAnomalyDetector) !void {
    if (value.account_id) |v| {
        try buf.appendSlice(allocator, "<AccountId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccountId>");
    }
    if (value.dimensions) |v| {
        try buf.appendSlice(allocator, "<Dimensions>");
        try serializeDimensions(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Dimensions>");
    }
    if (value.metric_name) |v| {
        try buf.appendSlice(allocator, "<MetricName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</MetricName>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(allocator, "<Namespace>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Namespace>");
    }
    if (value.stat) |v| {
        try buf.appendSlice(allocator, "<Stat>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Stat>");
    }
}

pub fn serializeStatisticSet(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StatisticSet) !void {
    try buf.appendSlice(allocator, "<Maximum>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.maximum}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Maximum>");
    try buf.appendSlice(allocator, "<Minimum>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.minimum}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Minimum>");
    try buf.appendSlice(allocator, "<SampleCount>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.sample_count}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</SampleCount>");
    try buf.appendSlice(allocator, "<Sum>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.sum}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</Sum>");
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

