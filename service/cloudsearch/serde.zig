const aws = @import("aws");
const std = @import("std");

const AccessPoliciesStatus = @import("access_policies_status.zig").AccessPoliciesStatus;
const AlgorithmicStemming = @import("algorithmic_stemming.zig").AlgorithmicStemming;
const AnalysisOptions = @import("analysis_options.zig").AnalysisOptions;
const AnalysisScheme = @import("analysis_scheme.zig").AnalysisScheme;
const AnalysisSchemeLanguage = @import("analysis_scheme_language.zig").AnalysisSchemeLanguage;
const AnalysisSchemeStatus = @import("analysis_scheme_status.zig").AnalysisSchemeStatus;
const AvailabilityOptionsStatus = @import("availability_options_status.zig").AvailabilityOptionsStatus;
const DateArrayOptions = @import("date_array_options.zig").DateArrayOptions;
const DateOptions = @import("date_options.zig").DateOptions;
const DocumentSuggesterOptions = @import("document_suggester_options.zig").DocumentSuggesterOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const DomainEndpointOptionsStatus = @import("domain_endpoint_options_status.zig").DomainEndpointOptionsStatus;
const DomainStatus = @import("domain_status.zig").DomainStatus;
const DoubleArrayOptions = @import("double_array_options.zig").DoubleArrayOptions;
const DoubleOptions = @import("double_options.zig").DoubleOptions;
const Expression = @import("expression.zig").Expression;
const ExpressionStatus = @import("expression_status.zig").ExpressionStatus;
const IndexField = @import("index_field.zig").IndexField;
const IndexFieldStatus = @import("index_field_status.zig").IndexFieldStatus;
const IndexFieldType = @import("index_field_type.zig").IndexFieldType;
const IntArrayOptions = @import("int_array_options.zig").IntArrayOptions;
const IntOptions = @import("int_options.zig").IntOptions;
const LatLonOptions = @import("lat_lon_options.zig").LatLonOptions;
const Limits = @import("limits.zig").Limits;
const LiteralArrayOptions = @import("literal_array_options.zig").LiteralArrayOptions;
const LiteralOptions = @import("literal_options.zig").LiteralOptions;
const OptionState = @import("option_state.zig").OptionState;
const OptionStatus = @import("option_status.zig").OptionStatus;
const PartitionInstanceType = @import("partition_instance_type.zig").PartitionInstanceType;
const ScalingParameters = @import("scaling_parameters.zig").ScalingParameters;
const ScalingParametersStatus = @import("scaling_parameters_status.zig").ScalingParametersStatus;
const ServiceEndpoint = @import("service_endpoint.zig").ServiceEndpoint;
const Suggester = @import("suggester.zig").Suggester;
const SuggesterFuzzyMatching = @import("suggester_fuzzy_matching.zig").SuggesterFuzzyMatching;
const SuggesterStatus = @import("suggester_status.zig").SuggesterStatus;
const TLSSecurityPolicy = @import("tls_security_policy.zig").TLSSecurityPolicy;
const TextArrayOptions = @import("text_array_options.zig").TextArrayOptions;
const TextOptions = @import("text_options.zig").TextOptions;

pub fn deserializeAnalysisSchemeStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AnalysisSchemeStatus {
    var list: std.ArrayList(AnalysisSchemeStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAnalysisSchemeStatus(allocator, reader));
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

pub fn deserializeDomainStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DomainStatus {
    var list: std.ArrayList(DomainStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDomainStatus(allocator, reader));
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

pub fn deserializeExpressionStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ExpressionStatus {
    var list: std.ArrayList(ExpressionStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeExpressionStatus(allocator, reader));
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

pub fn deserializeFieldNameList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeIndexFieldStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const IndexFieldStatus {
    var list: std.ArrayList(IndexFieldStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeIndexFieldStatus(allocator, reader));
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

pub fn deserializeSuggesterStatusList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SuggesterStatus {
    var list: std.ArrayList(SuggesterStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSuggesterStatus(allocator, reader));
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

pub fn deserializeDomainNameMap(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeAccessPoliciesStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessPoliciesStatus {
    var result: AccessPoliciesStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeAnalysisOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnalysisOptions {
    var result: AnalysisOptions = undefined;
    result.algorithmic_stemming = null;
    result.japanese_tokenization_dictionary = null;
    result.stemming_dictionary = null;
    result.stopwords = null;
    result.synonyms = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlgorithmicStemming")) {
                    result.algorithmic_stemming = AlgorithmicStemming.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JapaneseTokenizationDictionary")) {
                    result.japanese_tokenization_dictionary = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StemmingDictionary")) {
                    result.stemming_dictionary = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stopwords")) {
                    result.stopwords = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Synonyms")) {
                    result.synonyms = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnalysisScheme(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnalysisScheme {
    var result: AnalysisScheme = undefined;
    result.analysis_options = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnalysisOptions")) {
                    result.analysis_options = try deserializeAnalysisOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "AnalysisSchemeLanguage")) {
                    result.analysis_scheme_language = AnalysisSchemeLanguage.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "AnalysisSchemeName")) {
                    result.analysis_scheme_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnalysisSchemeStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AnalysisSchemeStatus {
    var result: AnalysisSchemeStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeAnalysisScheme(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeAvailabilityOptionsStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AvailabilityOptionsStatus {
    var result: AvailabilityOptionsStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeDateArrayOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DateArrayOptions {
    var result: DateArrayOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.source_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDateOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DateOptions {
    var result: DateOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.sort_enabled = null;
    result.source_field = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDocumentSuggesterOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DocumentSuggesterOptions {
    var result: DocumentSuggesterOptions = undefined;
    result.fuzzy_matching = null;
    result.sort_expression = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FuzzyMatching")) {
                    result.fuzzy_matching = SuggesterFuzzyMatching.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SortExpression")) {
                    result.sort_expression = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDomainEndpointOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DomainEndpointOptions {
    _ = allocator;
    var result: DomainEndpointOptions = undefined;
    result.enforce_https = null;
    result.tls_security_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnforceHTTPS")) {
                    result.enforce_https = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TLSSecurityPolicy")) {
                    result.tls_security_policy = TLSSecurityPolicy.fromWireName(try reader.readElementText());
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

pub fn deserializeDomainEndpointOptionsStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DomainEndpointOptionsStatus {
    var result: DomainEndpointOptionsStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeDomainEndpointOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeDomainStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DomainStatus {
    var result: DomainStatus = undefined;
    result.arn = null;
    result.created = null;
    result.deleted = null;
    result.doc_service = null;
    result.limits = null;
    result.processing = null;
    result.search_instance_count = null;
    result.search_instance_type = null;
    result.search_partition_count = null;
    result.search_service = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Created")) {
                    result.created = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Deleted")) {
                    result.deleted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DocService")) {
                    result.doc_service = try deserializeServiceEndpoint(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DomainId")) {
                    result.domain_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Limits")) {
                    result.limits = try deserializeLimits(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Processing")) {
                    result.processing = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RequiresIndexDocuments")) {
                    result.requires_index_documents = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchInstanceCount")) {
                    result.search_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SearchInstanceType")) {
                    result.search_instance_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SearchPartitionCount")) {
                    result.search_partition_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SearchService")) {
                    result.search_service = try deserializeServiceEndpoint(allocator, reader);
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

pub fn deserializeDoubleArrayOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DoubleArrayOptions {
    var result: DoubleArrayOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.source_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDoubleOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DoubleOptions {
    var result: DoubleOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.sort_enabled = null;
    result.source_field = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeExpression(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Expression {
    var result: Expression = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExpressionName")) {
                    result.expression_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpressionValue")) {
                    result.expression_value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeExpressionStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ExpressionStatus {
    var result: ExpressionStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeExpression(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeIndexField(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IndexField {
    var result: IndexField = undefined;
    result.date_array_options = null;
    result.date_options = null;
    result.double_array_options = null;
    result.double_options = null;
    result.int_array_options = null;
    result.int_options = null;
    result.lat_lon_options = null;
    result.literal_array_options = null;
    result.literal_options = null;
    result.text_array_options = null;
    result.text_options = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DateArrayOptions")) {
                    result.date_array_options = try deserializeDateArrayOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DateOptions")) {
                    result.date_options = try deserializeDateOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DoubleArrayOptions")) {
                    result.double_array_options = try deserializeDoubleArrayOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "DoubleOptions")) {
                    result.double_options = try deserializeDoubleOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IndexFieldName")) {
                    result.index_field_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IndexFieldType")) {
                    result.index_field_type = IndexFieldType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "IntArrayOptions")) {
                    result.int_array_options = try deserializeIntArrayOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "IntOptions")) {
                    result.int_options = try deserializeIntOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LatLonOptions")) {
                    result.lat_lon_options = try deserializeLatLonOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LiteralArrayOptions")) {
                    result.literal_array_options = try deserializeLiteralArrayOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LiteralOptions")) {
                    result.literal_options = try deserializeLiteralOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TextArrayOptions")) {
                    result.text_array_options = try deserializeTextArrayOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TextOptions")) {
                    result.text_options = try deserializeTextOptions(allocator, reader);
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

pub fn deserializeIndexFieldStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IndexFieldStatus {
    var result: IndexFieldStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeIndexField(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeIntArrayOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IntArrayOptions {
    var result: IntArrayOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.source_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeIntOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !IntOptions {
    var result: IntOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.sort_enabled = null;
    result.source_field = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLatLonOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LatLonOptions {
    var result: LatLonOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.sort_enabled = null;
    result.source_field = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLimits(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Limits {
    _ = allocator;
    var result: Limits = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaximumPartitionCount")) {
                    result.maximum_partition_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "MaximumReplicationCount")) {
                    result.maximum_replication_count = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
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

pub fn deserializeLiteralArrayOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LiteralArrayOptions {
    var result: LiteralArrayOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.source_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLiteralOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LiteralOptions {
    var result: LiteralOptions = undefined;
    result.default_value = null;
    result.facet_enabled = null;
    result.return_enabled = null;
    result.search_enabled = null;
    result.sort_enabled = null;
    result.source_field = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOptionStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OptionStatus {
    _ = allocator;
    var result: OptionStatus = undefined;
    result.pending_deletion = null;
    result.update_version = 0;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PendingDeletion")) {
                    result.pending_deletion = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = OptionState.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UpdateDate")) {
                    result.update_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateVersion")) {
                    result.update_version = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeScalingParameters(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScalingParameters {
    _ = allocator;
    var result: ScalingParameters = undefined;
    result.desired_instance_type = null;
    result.desired_partition_count = 0;
    result.desired_replication_count = 0;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DesiredInstanceType")) {
                    result.desired_instance_type = PartitionInstanceType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DesiredPartitionCount")) {
                    result.desired_partition_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DesiredReplicationCount")) {
                    result.desired_replication_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeScalingParametersStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScalingParametersStatus {
    var result: ScalingParametersStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeScalingParameters(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeServiceEndpoint(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServiceEndpoint {
    var result: ServiceEndpoint = undefined;
    result.endpoint = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSuggester(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Suggester {
    var result: Suggester = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DocumentSuggesterOptions")) {
                    result.document_suggester_options = try deserializeDocumentSuggesterOptions(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SuggesterName")) {
                    result.suggester_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeSuggesterStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SuggesterStatus {
    var result: SuggesterStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeSuggester(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(allocator, reader);
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

pub fn deserializeTextArrayOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TextArrayOptions {
    var result: TextArrayOptions = undefined;
    result.analysis_scheme = null;
    result.default_value = null;
    result.highlight_enabled = null;
    result.return_enabled = null;
    result.source_fields = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnalysisScheme")) {
                    result.analysis_scheme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HighlightEnabled")) {
                    result.highlight_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTextOptions(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TextOptions {
    var result: TextOptions = undefined;
    result.analysis_scheme = null;
    result.default_value = null;
    result.highlight_enabled = null;
    result.return_enabled = null;
    result.sort_enabled = null;
    result.source_field = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnalysisScheme")) {
                    result.analysis_scheme = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HighlightEnabled")) {
                    result.highlight_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try allocator.dupe(u8, try reader.readElementText());
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

pub fn serializeDomainNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeDynamicFieldNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStandardNameList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeAnalysisOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalysisOptions) !void {
    if (value.algorithmic_stemming) |v| {
        try buf.appendSlice(allocator, "<AlgorithmicStemming>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</AlgorithmicStemming>");
    }
    if (value.japanese_tokenization_dictionary) |v| {
        try buf.appendSlice(allocator, "<JapaneseTokenizationDictionary>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</JapaneseTokenizationDictionary>");
    }
    if (value.stemming_dictionary) |v| {
        try buf.appendSlice(allocator, "<StemmingDictionary>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StemmingDictionary>");
    }
    if (value.stopwords) |v| {
        try buf.appendSlice(allocator, "<Stopwords>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Stopwords>");
    }
    if (value.synonyms) |v| {
        try buf.appendSlice(allocator, "<Synonyms>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Synonyms>");
    }
}

pub fn serializeAnalysisScheme(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalysisScheme) !void {
    if (value.analysis_options) |v| {
        try buf.appendSlice(allocator, "<AnalysisOptions>");
        try serializeAnalysisOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</AnalysisOptions>");
    }
    try buf.appendSlice(allocator, "<AnalysisSchemeLanguage>");
    try buf.appendSlice(allocator, value.analysis_scheme_language.wireName());
    try buf.appendSlice(allocator, "</AnalysisSchemeLanguage>");
    try buf.appendSlice(allocator, "<AnalysisSchemeName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.analysis_scheme_name);
    try buf.appendSlice(allocator, "</AnalysisSchemeName>");
}

pub fn serializeDateArrayOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DateArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(allocator, "<SourceFields>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceFields>");
    }
}

pub fn serializeDateOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DateOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(allocator, "<SortEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(allocator, "<SourceField>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceField>");
    }
}

pub fn serializeDocumentSuggesterOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DocumentSuggesterOptions) !void {
    if (value.fuzzy_matching) |v| {
        try buf.appendSlice(allocator, "<FuzzyMatching>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</FuzzyMatching>");
    }
    if (value.sort_expression) |v| {
        try buf.appendSlice(allocator, "<SortExpression>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SortExpression>");
    }
    try buf.appendSlice(allocator, "<SourceField>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.source_field);
    try buf.appendSlice(allocator, "</SourceField>");
}

pub fn serializeDomainEndpointOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DomainEndpointOptions) !void {
    if (value.enforce_https) |v| {
        try buf.appendSlice(allocator, "<EnforceHTTPS>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</EnforceHTTPS>");
    }
    if (value.tls_security_policy) |v| {
        try buf.appendSlice(allocator, "<TLSSecurityPolicy>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</TLSSecurityPolicy>");
    }
}

pub fn serializeDoubleArrayOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DoubleArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(allocator, "<SourceFields>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceFields>");
    }
}

pub fn serializeDoubleOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DoubleOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(allocator, "<SortEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(allocator, "<SourceField>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceField>");
    }
}

pub fn serializeExpression(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Expression) !void {
    try buf.appendSlice(allocator, "<ExpressionName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.expression_name);
    try buf.appendSlice(allocator, "</ExpressionName>");
    try buf.appendSlice(allocator, "<ExpressionValue>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.expression_value);
    try buf.appendSlice(allocator, "</ExpressionValue>");
}

pub fn serializeIndexField(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IndexField) !void {
    if (value.date_array_options) |v| {
        try buf.appendSlice(allocator, "<DateArrayOptions>");
        try serializeDateArrayOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</DateArrayOptions>");
    }
    if (value.date_options) |v| {
        try buf.appendSlice(allocator, "<DateOptions>");
        try serializeDateOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</DateOptions>");
    }
    if (value.double_array_options) |v| {
        try buf.appendSlice(allocator, "<DoubleArrayOptions>");
        try serializeDoubleArrayOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</DoubleArrayOptions>");
    }
    if (value.double_options) |v| {
        try buf.appendSlice(allocator, "<DoubleOptions>");
        try serializeDoubleOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</DoubleOptions>");
    }
    try buf.appendSlice(allocator, "<IndexFieldName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.index_field_name);
    try buf.appendSlice(allocator, "</IndexFieldName>");
    try buf.appendSlice(allocator, "<IndexFieldType>");
    try buf.appendSlice(allocator, value.index_field_type.wireName());
    try buf.appendSlice(allocator, "</IndexFieldType>");
    if (value.int_array_options) |v| {
        try buf.appendSlice(allocator, "<IntArrayOptions>");
        try serializeIntArrayOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</IntArrayOptions>");
    }
    if (value.int_options) |v| {
        try buf.appendSlice(allocator, "<IntOptions>");
        try serializeIntOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</IntOptions>");
    }
    if (value.lat_lon_options) |v| {
        try buf.appendSlice(allocator, "<LatLonOptions>");
        try serializeLatLonOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</LatLonOptions>");
    }
    if (value.literal_array_options) |v| {
        try buf.appendSlice(allocator, "<LiteralArrayOptions>");
        try serializeLiteralArrayOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</LiteralArrayOptions>");
    }
    if (value.literal_options) |v| {
        try buf.appendSlice(allocator, "<LiteralOptions>");
        try serializeLiteralOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</LiteralOptions>");
    }
    if (value.text_array_options) |v| {
        try buf.appendSlice(allocator, "<TextArrayOptions>");
        try serializeTextArrayOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</TextArrayOptions>");
    }
    if (value.text_options) |v| {
        try buf.appendSlice(allocator, "<TextOptions>");
        try serializeTextOptions(allocator, buf, v);
        try buf.appendSlice(allocator, "</TextOptions>");
    }
}

pub fn serializeIntArrayOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(allocator, "<SourceFields>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceFields>");
    }
}

pub fn serializeIntOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(allocator, "<SortEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(allocator, "<SourceField>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceField>");
    }
}

pub fn serializeLatLonOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LatLonOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(allocator, "<SortEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(allocator, "<SourceField>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceField>");
    }
}

pub fn serializeLiteralArrayOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LiteralArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(allocator, "<SourceFields>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceFields>");
    }
}

pub fn serializeLiteralOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LiteralOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(allocator, "<FacetEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(allocator, "<SearchEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(allocator, "<SortEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(allocator, "<SourceField>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceField>");
    }
}

pub fn serializeScalingParameters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScalingParameters) !void {
    if (value.desired_instance_type) |v| {
        try buf.appendSlice(allocator, "<DesiredInstanceType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</DesiredInstanceType>");
    }
    try buf.appendSlice(allocator, "<DesiredPartitionCount>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.desired_partition_count}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</DesiredPartitionCount>");
    try buf.appendSlice(allocator, "<DesiredReplicationCount>");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{value.desired_replication_count}) catch "";
        try buf.appendSlice(allocator, num_str);
    }
    try buf.appendSlice(allocator, "</DesiredReplicationCount>");
}

pub fn serializeSuggester(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Suggester) !void {
    try buf.appendSlice(allocator, "<DocumentSuggesterOptions>");
    try serializeDocumentSuggesterOptions(allocator, buf, value.document_suggester_options);
    try buf.appendSlice(allocator, "</DocumentSuggesterOptions>");
    try buf.appendSlice(allocator, "<SuggesterName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.suggester_name);
    try buf.appendSlice(allocator, "</SuggesterName>");
}

pub fn serializeTextArrayOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TextArrayOptions) !void {
    if (value.analysis_scheme) |v| {
        try buf.appendSlice(allocator, "<AnalysisScheme>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AnalysisScheme>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.highlight_enabled) |v| {
        try buf.appendSlice(allocator, "<HighlightEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</HighlightEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(allocator, "<SourceFields>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceFields>");
    }
}

pub fn serializeTextOptions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TextOptions) !void {
    if (value.analysis_scheme) |v| {
        try buf.appendSlice(allocator, "<AnalysisScheme>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AnalysisScheme>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(allocator, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</DefaultValue>");
    }
    if (value.highlight_enabled) |v| {
        try buf.appendSlice(allocator, "<HighlightEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</HighlightEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(allocator, "<ReturnEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</ReturnEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(allocator, "<SortEnabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(allocator, "<SourceField>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</SourceField>");
    }
}

