const std = @import("std");

/// Type of security risk.
pub const RiskType = enum {
    /// Cross-site scripting vulnerability.
    cross_site_scripting,
    /// Default or weak credentials detected.
    default_credentials,
    /// Insecure direct object reference vulnerability.
    insecure_direct_object_reference,
    /// Privilege escalation vulnerability.
    privilege_escalation,
    /// Server-side template injection vulnerability.
    server_side_template_injection,
    /// Command injection vulnerability.
    command_injection,
    /// Code injection vulnerability.
    code_injection,
    /// SQL injection vulnerability.
    sql_injection,
    /// Arbitrary file upload vulnerability.
    arbitrary_file_upload,
    /// Insecure deserialization vulnerability.
    insecure_deserialization,
    /// Local file inclusion vulnerability.
    local_file_inclusion,
    /// Information disclosure vulnerability.
    information_disclosure,
    /// Path traversal vulnerability.
    path_traversal,
    /// Server-side request forgery vulnerability.
    server_side_request_forgery,
    /// JSON Web Token vulnerability.
    json_web_token_vulnerabilities,
    /// XML external entity vulnerability.
    xml_external_entity,
    /// File deletion vulnerability.
    file_deletion,
    /// Other risk type not covered by specific categories.
    other,
    /// GraphQL-specific vulnerability.
    graphql_vulnerabilities,
    /// Business logic vulnerability.
    business_logic_vulnerabilities,
    /// Cryptographic vulnerability.
    cryptographic_vulnerabilities,
    /// Denial of service vulnerability.
    denial_of_service,
    /// Unauthorized file access vulnerability.
    file_access,
    /// Unauthorized file creation vulnerability.
    file_creation,
    /// Unauthorized database modification.
    database_modification,
    /// Unauthorized database access.
    database_access,
    /// Outbound service request vulnerability.
    outbound_service_request,
    /// Unknown risk type.
    unknown,

    pub const json_field_names = .{
        .cross_site_scripting = "CROSS_SITE_SCRIPTING",
        .default_credentials = "DEFAULT_CREDENTIALS",
        .insecure_direct_object_reference = "INSECURE_DIRECT_OBJECT_REFERENCE",
        .privilege_escalation = "PRIVILEGE_ESCALATION",
        .server_side_template_injection = "SERVER_SIDE_TEMPLATE_INJECTION",
        .command_injection = "COMMAND_INJECTION",
        .code_injection = "CODE_INJECTION",
        .sql_injection = "SQL_INJECTION",
        .arbitrary_file_upload = "ARBITRARY_FILE_UPLOAD",
        .insecure_deserialization = "INSECURE_DESERIALIZATION",
        .local_file_inclusion = "LOCAL_FILE_INCLUSION",
        .information_disclosure = "INFORMATION_DISCLOSURE",
        .path_traversal = "PATH_TRAVERSAL",
        .server_side_request_forgery = "SERVER_SIDE_REQUEST_FORGERY",
        .json_web_token_vulnerabilities = "JSON_WEB_TOKEN_VULNERABILITIES",
        .xml_external_entity = "XML_EXTERNAL_ENTITY",
        .file_deletion = "FILE_DELETION",
        .other = "OTHER",
        .graphql_vulnerabilities = "GRAPHQL_VULNERABILITIES",
        .business_logic_vulnerabilities = "BUSINESS_LOGIC_VULNERABILITIES",
        .cryptographic_vulnerabilities = "CRYPTOGRAPHIC_VULNERABILITIES",
        .denial_of_service = "DENIAL_OF_SERVICE",
        .file_access = "FILE_ACCESS",
        .file_creation = "FILE_CREATION",
        .database_modification = "DATABASE_MODIFICATION",
        .database_access = "DATABASE_ACCESS",
        .outbound_service_request = "OUTBOUND_SERVICE_REQUEST",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cross_site_scripting => "CROSS_SITE_SCRIPTING",
            .default_credentials => "DEFAULT_CREDENTIALS",
            .insecure_direct_object_reference => "INSECURE_DIRECT_OBJECT_REFERENCE",
            .privilege_escalation => "PRIVILEGE_ESCALATION",
            .server_side_template_injection => "SERVER_SIDE_TEMPLATE_INJECTION",
            .command_injection => "COMMAND_INJECTION",
            .code_injection => "CODE_INJECTION",
            .sql_injection => "SQL_INJECTION",
            .arbitrary_file_upload => "ARBITRARY_FILE_UPLOAD",
            .insecure_deserialization => "INSECURE_DESERIALIZATION",
            .local_file_inclusion => "LOCAL_FILE_INCLUSION",
            .information_disclosure => "INFORMATION_DISCLOSURE",
            .path_traversal => "PATH_TRAVERSAL",
            .server_side_request_forgery => "SERVER_SIDE_REQUEST_FORGERY",
            .json_web_token_vulnerabilities => "JSON_WEB_TOKEN_VULNERABILITIES",
            .xml_external_entity => "XML_EXTERNAL_ENTITY",
            .file_deletion => "FILE_DELETION",
            .other => "OTHER",
            .graphql_vulnerabilities => "GRAPHQL_VULNERABILITIES",
            .business_logic_vulnerabilities => "BUSINESS_LOGIC_VULNERABILITIES",
            .cryptographic_vulnerabilities => "CRYPTOGRAPHIC_VULNERABILITIES",
            .denial_of_service => "DENIAL_OF_SERVICE",
            .file_access => "FILE_ACCESS",
            .file_creation => "FILE_CREATION",
            .database_modification => "DATABASE_MODIFICATION",
            .database_access => "DATABASE_ACCESS",
            .outbound_service_request => "OUTBOUND_SERVICE_REQUEST",
            .unknown => "UNKNOWN",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
