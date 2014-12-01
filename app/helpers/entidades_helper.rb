module EntidadesHelper

    # PROCESA un string representando cargo y persona  e intenta obtenerlo de la base de datos.
    # el formato es "cargo: apellido, nombre"
    # Devuelve un hash con la siguiente informacion:
    # :cargo_text => texto con el cargo ingresado, nil si no se ingreso
    # :cargo => objeto Cargo si se encontro en la base de datos sino nil
    # :persona_text=> Apellido y nombre de la persona si no se ingreso nil
    # :persona => Objeto Persona  si se encontro en la base de datos sino nil

    def parse_text_to_cargo_persona(cp)
      pos = cp.index(':')
      textcargo = ""
      textpersona = ""
      if !pos.nil?
         # significa que esta el signo ':' o sea el cargo
          textcargo = cp[0,pos]
          textpersona = cp[pos+1..-1].strip
      else
        textpersona = cp
      end
      #separamos el apellido del nombre
      pos = textpersona.index(',')
      apellido = ""
      nombre = ""
      if !pos.nil?
         # significa que esta el signo '' o sea el apellido y nombre
          apellido = textpersona[0,pos]
          nombre = textpersona[pos+1..-1].strip
      else
        apellido = textpersona
      end

      textcargolike=textcargo.gsub(/[!%_]/) { |x| '!' + x }
      apellidolike=apellido.gsub(/[!%_]/) { |x| '!' + x }
      nombrelike=nombre.gsub(/[!%_]/) { |x| '!' + x }
      if !textcargo.blank?
        cargo = Cargo.where(nombre: textcargo).first || Cargo.where("nombre like ?","%#{textcargolike}%").first||nil
      end
      if !textpersona.blank?
        persona = Persona.where("apellido =? and nombre =?",apellido,nombre).first || Persona.where("apellido like ? and nombre like ?","%#{apellidolike}%","%#{nombrelike}%").first || nil
      end
      result = {:cargo_text =>textcargo, :cargo => cargo, :persona_text=> textpersona, :persona => persona }

    end


end
