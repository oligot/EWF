note
	description: "Facilities inheritance to add URI base routing to a routed object."

	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_ROUTED_URI_HELPER

inherit
	WSF_ROUTED

feature -- Mapping helper: uri

	map_uri (a_uri: READABLE_STRING_8; h: WSF_URI_HANDLER)
			-- Map `h' as handler for `a_uri'
		do
			map_uri_with_request_methods (a_uri, h, Void)
		end

	map_uri_with_request_methods (a_uri: READABLE_STRING_8; h: WSF_URI_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_uri' for request methods `rqst_methods'.
		do
			router.map_with_request_methods (create {WSF_URI_MAPPING}.make (a_uri, h), rqst_methods)
		end

feature -- Mapping helper: uri agent		

	map_uri_agent (a_uri: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]])
			-- Map `proc' as handler for `a_uri'
		do
			map_uri_agent_with_request_methods (a_uri, proc, Void)
		end

	map_uri_agent_with_request_methods (a_uri: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_uri' for request methods `rqst_methods'.
		do
			map_uri_with_request_methods (a_uri, create {WSF_URI_AGENT_HANDLER}.make (proc), rqst_methods)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
