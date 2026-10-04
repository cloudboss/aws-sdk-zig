const std = @import("std");

const cognitoidentity = @import("cognitoidentity");
const dynamodb = @import("dynamodb");
const ec2 = @import("ec2");
const lambda = @import("lambda");
const s3 = @import("s3");
const sts = @import("sts");

fn ParserChecks(comptime service: type) type {
    return struct {
        fn check(
            allocator: std.mem.Allocator,
            body: []const u8,
            expected_tag: []const u8,
            expected_code: []const u8,
            expected_message: []const u8,
            expected_request_id: []const u8,
            status: u16,
        ) !void {
            const source = try allocator.dupe(u8, body);
            defer allocator.free(source);
            var diagnostic = try service.errors.parseErrorResponse(allocator, source, status);
            defer diagnostic.deinit();
            @memset(source, '?');

            try std.testing.expectEqualStrings(expected_tag, @tagName(diagnostic.kind));
            try std.testing.expectEqualStrings(expected_code, diagnostic.code());
            try std.testing.expectEqualStrings(expected_message, diagnostic.message());
            try std.testing.expectEqualStrings(expected_request_id, diagnostic.requestId());
            if (diagnostic.kind == .unknown) {
                try std.testing.expectEqual(status, diagnostic.httpStatus());
            }
        }
    };
}

test "shared error parsers own diagnostics and propagate allocation failures" {
    const cases = .{
        .{
            dynamodb,
            \\{"__type":"db#ConditionalCheckFailedException","message":"missing",
            \\ "Item":{"pk":{"S":"original"}}}
            ,
            "conditional_check_failed_exception",
            "ConditionalCheckFailedException",
            "",
        },
        .{
            cognitoidentity,
            \\{"__type":"id#ResourceNotFoundException","message":"missing"}
            ,
            "resource_not_found_exception",
            "ResourceNotFoundException",
            "",
        },
        .{
            lambda,
            \\{"__type":"lambda#ResourceNotFoundException","message":"missing"}
            ,
            "resource_not_found_exception",
            "ResourceNotFoundException",
            "",
        },
        .{
            sts,
            \\<ErrorResponse><Error><Code>ExpiredTokenException</Code><Message>missing</Message>
            \\</Error><RequestId>query-request</RequestId></ErrorResponse>
            ,
            "expired_token_exception",
            "ExpiredTokenException",
            "query-request",
        },
        .{
            s3,
            \\<Error><Code>NoSuchKey</Code><Message>missing</Message>
            \\<RequestId>xml-request</RequestId>
            \\</Error>
            ,
            "no_such_key",
            "NoSuchKey",
            "xml-request",
        },
        .{
            ec2,
            \\<Response><Errors><Error><Code>InvalidParameterValue</Code><Message>missing</Message>
            \\</Error></Errors><RequestID>ec2-request</RequestID></Response>
            ,
            "unknown",
            "InvalidParameterValue",
            "ec2-request",
        },
    };
    inline for (cases) |case| {
        const check = ParserChecks(case[0]).check;
        try std.testing.checkAllAllocationFailures(std.testing.allocator, check, .{
            case[1], case[2], case[3], "missing", case[4], 400,
        });
    }
}

test "malformed modeled error retains the fallback diagnostic" {
    const check = ParserChecks(dynamodb).check;
    try std.testing.checkAllAllocationFailures(std.testing.allocator, check, .{
        \\{"__type":"ConditionalCheckFailedException","message":"missing","Item":[]}
        ,
        "unknown",
        "ConditionalCheckFailedException",
        "missing",
        "",
        409,
    });
}

test "empty error body retains HTTP status in every protocol" {
    inline for (.{ dynamodb, cognitoidentity, lambda, sts, s3, ec2 }) |service| {
        const check = ParserChecks(service).check;
        try std.testing.checkAllAllocationFailures(std.testing.allocator, check, .{
            "", "unknown", "Unknown", "", "", 503,
        });
    }
}
