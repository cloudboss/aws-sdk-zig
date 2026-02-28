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

pub fn deserializeAnalysisSchemeStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AnalysisSchemeStatus {
    var list: std.ArrayList(AnalysisSchemeStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAnalysisSchemeStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDomainStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DomainStatus {
    var list: std.ArrayList(DomainStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDomainStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeExpressionStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ExpressionStatus {
    var list: std.ArrayList(ExpressionStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeExpressionStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFieldNameList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeIndexFieldStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const IndexFieldStatus {
    var list: std.ArrayList(IndexFieldStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeIndexFieldStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSuggesterStatusList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SuggesterStatus {
    var list: std.ArrayList(SuggesterStatus) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSuggesterStatus(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDomainNameMap(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccessPoliciesStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessPoliciesStatus {
    var result: AccessPoliciesStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeAnalysisOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnalysisOptions {
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
                    result.algorithmic_stemming = std.meta.stringToEnum(AlgorithmicStemming, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "JapaneseTokenizationDictionary")) {
                    result.japanese_tokenization_dictionary = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StemmingDictionary")) {
                    result.stemming_dictionary = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stopwords")) {
                    result.stopwords = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Synonyms")) {
                    result.synonyms = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnalysisScheme(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnalysisScheme {
    var result: AnalysisScheme = undefined;
    result.analysis_options = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnalysisOptions")) {
                    result.analysis_options = try deserializeAnalysisOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "AnalysisSchemeLanguage")) {
                    result.analysis_scheme_language = std.meta.stringToEnum(AnalysisSchemeLanguage, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AnalysisSchemeName")) {
                    result.analysis_scheme_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnalysisSchemeStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnalysisSchemeStatus {
    var result: AnalysisSchemeStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeAnalysisScheme(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeAvailabilityOptionsStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AvailabilityOptionsStatus {
    var result: AvailabilityOptionsStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeDateArrayOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DateArrayOptions {
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
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDateOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DateOptions {
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
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDocumentSuggesterOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DocumentSuggesterOptions {
    var result: DocumentSuggesterOptions = undefined;
    result.fuzzy_matching = null;
    result.sort_expression = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FuzzyMatching")) {
                    result.fuzzy_matching = std.meta.stringToEnum(SuggesterFuzzyMatching, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SortExpression")) {
                    result.sort_expression = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDomainEndpointOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainEndpointOptions {
    _ = alloc;
    var result: DomainEndpointOptions = undefined;
    result.enforce_https = null;
    result.tls_security_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnforceHTTPS")) {
                    result.enforce_https = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TLSSecurityPolicy")) {
                    result.tls_security_policy = std.meta.stringToEnum(TLSSecurityPolicy, try reader.readElementText());
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

pub fn deserializeDomainEndpointOptionsStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainEndpointOptionsStatus {
    var result: DomainEndpointOptionsStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeDomainEndpointOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeDomainStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DomainStatus {
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
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Created")) {
                    result.created = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Deleted")) {
                    result.deleted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DocService")) {
                    result.doc_service = try deserializeServiceEndpoint(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DomainId")) {
                    result.domain_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DomainName")) {
                    result.domain_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Limits")) {
                    result.limits = try deserializeLimits(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Processing")) {
                    result.processing = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RequiresIndexDocuments")) {
                    result.requires_index_documents = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchInstanceCount")) {
                    result.search_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SearchInstanceType")) {
                    result.search_instance_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SearchPartitionCount")) {
                    result.search_partition_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SearchService")) {
                    result.search_service = try deserializeServiceEndpoint(reader, alloc);
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

pub fn deserializeDoubleArrayOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DoubleArrayOptions {
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
                    result.source_fields = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDoubleOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DoubleOptions {
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
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeExpression(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Expression {
    var result: Expression = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExpressionName")) {
                    result.expression_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpressionValue")) {
                    result.expression_value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeExpressionStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ExpressionStatus {
    var result: ExpressionStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeExpression(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeIndexField(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IndexField {
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
                    result.date_array_options = try deserializeDateArrayOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DateOptions")) {
                    result.date_options = try deserializeDateOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DoubleArrayOptions")) {
                    result.double_array_options = try deserializeDoubleArrayOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "DoubleOptions")) {
                    result.double_options = try deserializeDoubleOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IndexFieldName")) {
                    result.index_field_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IndexFieldType")) {
                    result.index_field_type = std.meta.stringToEnum(IndexFieldType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IntArrayOptions")) {
                    result.int_array_options = try deserializeIntArrayOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "IntOptions")) {
                    result.int_options = try deserializeIntOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LatLonOptions")) {
                    result.lat_lon_options = try deserializeLatLonOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LiteralArrayOptions")) {
                    result.literal_array_options = try deserializeLiteralArrayOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LiteralOptions")) {
                    result.literal_options = try deserializeLiteralOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TextArrayOptions")) {
                    result.text_array_options = try deserializeTextArrayOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TextOptions")) {
                    result.text_options = try deserializeTextOptions(reader, alloc);
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

pub fn deserializeIndexFieldStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IndexFieldStatus {
    var result: IndexFieldStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeIndexField(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeIntArrayOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IntArrayOptions {
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
                    result.source_fields = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeIntOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !IntOptions {
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
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLatLonOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LatLonOptions {
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
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLimits(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Limits {
    _ = alloc;
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

pub fn deserializeLiteralArrayOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LiteralArrayOptions {
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
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLiteralOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LiteralOptions {
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
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FacetEnabled")) {
                    result.facet_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SearchEnabled")) {
                    result.search_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOptionStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OptionStatus {
    _ = alloc;
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
                    result.state = std.meta.stringToEnum(OptionState, try reader.readElementText());
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

pub fn deserializeScalingParameters(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScalingParameters {
    _ = alloc;
    var result: ScalingParameters = undefined;
    result.desired_instance_type = null;
    result.desired_partition_count = 0;
    result.desired_replication_count = 0;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DesiredInstanceType")) {
                    result.desired_instance_type = std.meta.stringToEnum(PartitionInstanceType, try reader.readElementText());
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

pub fn deserializeScalingParametersStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScalingParametersStatus {
    var result: ScalingParametersStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeScalingParameters(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeServiceEndpoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServiceEndpoint {
    var result: ServiceEndpoint = undefined;
    result.endpoint = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Endpoint")) {
                    result.endpoint = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSuggester(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Suggester {
    var result: Suggester = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DocumentSuggesterOptions")) {
                    result.document_suggester_options = try deserializeDocumentSuggesterOptions(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SuggesterName")) {
                    result.suggester_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSuggesterStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SuggesterStatus {
    var result: SuggesterStatus = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try deserializeSuggester(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try deserializeOptionStatus(reader, alloc);
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

pub fn deserializeTextArrayOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TextArrayOptions {
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
                    result.analysis_scheme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HighlightEnabled")) {
                    result.highlight_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceFields")) {
                    result.source_fields = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTextOptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TextOptions {
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
                    result.analysis_scheme = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HighlightEnabled")) {
                    result.highlight_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ReturnEnabled")) {
                    result.return_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SortEnabled")) {
                    result.sort_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SourceField")) {
                    result.source_field = try alloc.dupe(u8, try reader.readElementText());
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

pub fn serializeDomainNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeDynamicFieldNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStandardNameList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAnalysisOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalysisOptions) !void {
    if (value.algorithmic_stemming) |v| {
        try buf.appendSlice(alloc, "<AlgorithmicStemming>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</AlgorithmicStemming>");
    }
    if (value.japanese_tokenization_dictionary) |v| {
        try buf.appendSlice(alloc, "<JapaneseTokenizationDictionary>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</JapaneseTokenizationDictionary>");
    }
    if (value.stemming_dictionary) |v| {
        try buf.appendSlice(alloc, "<StemmingDictionary>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StemmingDictionary>");
    }
    if (value.stopwords) |v| {
        try buf.appendSlice(alloc, "<Stopwords>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Stopwords>");
    }
    if (value.synonyms) |v| {
        try buf.appendSlice(alloc, "<Synonyms>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Synonyms>");
    }
}

pub fn serializeAnalysisScheme(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnalysisScheme) !void {
    if (value.analysis_options) |v| {
        try buf.appendSlice(alloc, "<AnalysisOptions>");
        try serializeAnalysisOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</AnalysisOptions>");
    }
    try buf.appendSlice(alloc, "<AnalysisSchemeLanguage>");
    try buf.appendSlice(alloc, @tagName(value.analysis_scheme_language));
    try buf.appendSlice(alloc, "</AnalysisSchemeLanguage>");
    try buf.appendSlice(alloc, "<AnalysisSchemeName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.analysis_scheme_name);
    try buf.appendSlice(alloc, "</AnalysisSchemeName>");
}

pub fn serializeDateArrayOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DateArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(alloc, "<SourceFields>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceFields>");
    }
}

pub fn serializeDateOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DateOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(alloc, "<SortEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(alloc, "<SourceField>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceField>");
    }
}

pub fn serializeDocumentSuggesterOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DocumentSuggesterOptions) !void {
    if (value.fuzzy_matching) |v| {
        try buf.appendSlice(alloc, "<FuzzyMatching>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</FuzzyMatching>");
    }
    if (value.sort_expression) |v| {
        try buf.appendSlice(alloc, "<SortExpression>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SortExpression>");
    }
    try buf.appendSlice(alloc, "<SourceField>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.source_field);
    try buf.appendSlice(alloc, "</SourceField>");
}

pub fn serializeDomainEndpointOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DomainEndpointOptions) !void {
    if (value.enforce_https) |v| {
        try buf.appendSlice(alloc, "<EnforceHTTPS>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</EnforceHTTPS>");
    }
    if (value.tls_security_policy) |v| {
        try buf.appendSlice(alloc, "<TLSSecurityPolicy>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</TLSSecurityPolicy>");
    }
}

pub fn serializeDoubleArrayOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DoubleArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(alloc, "<SourceFields>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceFields>");
    }
}

pub fn serializeDoubleOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DoubleOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(alloc, "<SortEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(alloc, "<SourceField>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceField>");
    }
}

pub fn serializeExpression(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Expression) !void {
    try buf.appendSlice(alloc, "<ExpressionName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.expression_name);
    try buf.appendSlice(alloc, "</ExpressionName>");
    try buf.appendSlice(alloc, "<ExpressionValue>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.expression_value);
    try buf.appendSlice(alloc, "</ExpressionValue>");
}

pub fn serializeIndexField(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: IndexField) !void {
    if (value.date_array_options) |v| {
        try buf.appendSlice(alloc, "<DateArrayOptions>");
        try serializeDateArrayOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</DateArrayOptions>");
    }
    if (value.date_options) |v| {
        try buf.appendSlice(alloc, "<DateOptions>");
        try serializeDateOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</DateOptions>");
    }
    if (value.double_array_options) |v| {
        try buf.appendSlice(alloc, "<DoubleArrayOptions>");
        try serializeDoubleArrayOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</DoubleArrayOptions>");
    }
    if (value.double_options) |v| {
        try buf.appendSlice(alloc, "<DoubleOptions>");
        try serializeDoubleOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</DoubleOptions>");
    }
    try buf.appendSlice(alloc, "<IndexFieldName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.index_field_name);
    try buf.appendSlice(alloc, "</IndexFieldName>");
    try buf.appendSlice(alloc, "<IndexFieldType>");
    try buf.appendSlice(alloc, @tagName(value.index_field_type));
    try buf.appendSlice(alloc, "</IndexFieldType>");
    if (value.int_array_options) |v| {
        try buf.appendSlice(alloc, "<IntArrayOptions>");
        try serializeIntArrayOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</IntArrayOptions>");
    }
    if (value.int_options) |v| {
        try buf.appendSlice(alloc, "<IntOptions>");
        try serializeIntOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</IntOptions>");
    }
    if (value.lat_lon_options) |v| {
        try buf.appendSlice(alloc, "<LatLonOptions>");
        try serializeLatLonOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</LatLonOptions>");
    }
    if (value.literal_array_options) |v| {
        try buf.appendSlice(alloc, "<LiteralArrayOptions>");
        try serializeLiteralArrayOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</LiteralArrayOptions>");
    }
    if (value.literal_options) |v| {
        try buf.appendSlice(alloc, "<LiteralOptions>");
        try serializeLiteralOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</LiteralOptions>");
    }
    if (value.text_array_options) |v| {
        try buf.appendSlice(alloc, "<TextArrayOptions>");
        try serializeTextArrayOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</TextArrayOptions>");
    }
    if (value.text_options) |v| {
        try buf.appendSlice(alloc, "<TextOptions>");
        try serializeTextOptions(alloc, buf, v);
        try buf.appendSlice(alloc, "</TextOptions>");
    }
}

pub fn serializeIntArrayOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(alloc, "<SourceFields>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceFields>");
    }
}

pub fn serializeIntOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: IntOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(alloc, "<SortEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(alloc, "<SourceField>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceField>");
    }
}

pub fn serializeLatLonOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LatLonOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(alloc, "<SortEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(alloc, "<SourceField>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceField>");
    }
}

pub fn serializeLiteralArrayOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LiteralArrayOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(alloc, "<SourceFields>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceFields>");
    }
}

pub fn serializeLiteralOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LiteralOptions) !void {
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.facet_enabled) |v| {
        try buf.appendSlice(alloc, "<FacetEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FacetEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.search_enabled) |v| {
        try buf.appendSlice(alloc, "<SearchEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SearchEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(alloc, "<SortEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(alloc, "<SourceField>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceField>");
    }
}

pub fn serializeScalingParameters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScalingParameters) !void {
    if (value.desired_instance_type) |v| {
        try buf.appendSlice(alloc, "<DesiredInstanceType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</DesiredInstanceType>");
    }
    if (value.desired_partition_count) |v| {
        try buf.appendSlice(alloc, "<DesiredPartitionCount>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DesiredPartitionCount>");
    }
    if (value.desired_replication_count) |v| {
        try buf.appendSlice(alloc, "<DesiredReplicationCount>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</DesiredReplicationCount>");
    }
}

pub fn serializeSuggester(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Suggester) !void {
    try buf.appendSlice(alloc, "<DocumentSuggesterOptions>");
    try serializeDocumentSuggesterOptions(alloc, buf, value.document_suggester_options);
    try buf.appendSlice(alloc, "</DocumentSuggesterOptions>");
    try buf.appendSlice(alloc, "<SuggesterName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.suggester_name);
    try buf.appendSlice(alloc, "</SuggesterName>");
}

pub fn serializeTextArrayOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TextArrayOptions) !void {
    if (value.analysis_scheme) |v| {
        try buf.appendSlice(alloc, "<AnalysisScheme>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AnalysisScheme>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.highlight_enabled) |v| {
        try buf.appendSlice(alloc, "<HighlightEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</HighlightEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.source_fields) |v| {
        try buf.appendSlice(alloc, "<SourceFields>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceFields>");
    }
}

pub fn serializeTextOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TextOptions) !void {
    if (value.analysis_scheme) |v| {
        try buf.appendSlice(alloc, "<AnalysisScheme>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AnalysisScheme>");
    }
    if (value.default_value) |v| {
        try buf.appendSlice(alloc, "<DefaultValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</DefaultValue>");
    }
    if (value.highlight_enabled) |v| {
        try buf.appendSlice(alloc, "<HighlightEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</HighlightEnabled>");
    }
    if (value.return_enabled) |v| {
        try buf.appendSlice(alloc, "<ReturnEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnEnabled>");
    }
    if (value.sort_enabled) |v| {
        try buf.appendSlice(alloc, "<SortEnabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</SortEnabled>");
    }
    if (value.source_field) |v| {
        try buf.appendSlice(alloc, "<SourceField>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</SourceField>");
    }
}

