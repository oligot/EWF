note
	description : "OpenShift example application"
	author		: "Olivier Ligot"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	WSF_DEFAULT_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service
		local
			l_env: EXECUTION_ENVIRONMENT
			l_factory: INET_ADDRESS_FACTORY
		do
			create l_env
			if attached l_env.get (Openshift_ip) as l_ip then
				create l_factory
				if attached l_factory.create_from_name (l_ip) as l_address then
					set_service_option ("ip", l_ip)
				else
					die ("could not parse " + Openshift_ip)
				end
			else
				die (Openshift_ip + " is not defined")
			end
			if attached l_env.get (Openshift_port) as l_port then
				if l_port.is_integer then
					set_service_option ("port", l_port)
				else
					die ("could not parse " + Openshift_port)
				end
			else
				die (Openshift_port + " is not defined")
			end
			set_service_option ("verbose", True)
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			res.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "text/plain"], ["Content-Length", "11"]>>)
			res.put_string ("Hello World")
		end

feature {NONE} -- Implementation

	die (a_message: STRING)
			-- Die with `a_message'.
		local
			l_exceptions: EXCEPTIONS
		do
			io.put_string (a_message)
			io.put_new_line
			create l_exceptions
			l_exceptions.die (1)
		end

	Openshift_ip: STRING = "OPENSHIFT_INTERNAL_IP"
			-- OpenShift IP environment variable name

	Openshift_port: STRING = "OPENSHIFT_INTERNAL_PORT"
			-- OpenShift port environment variable name

end
