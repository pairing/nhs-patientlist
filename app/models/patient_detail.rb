class PatientDetail
  extend Forwardable
  def_delegator :@admission, :currward
  def_delegators :@patient, :hospno, :name, :birthdate, :sex, :pmh, :allergies, :firstnames, :lastname, :pastmedhx

  alias :ward :currward
  alias :pmh :pastmedhx

  attr_reader :patient, :admission


  def self.admitted
    Admission.admitted.map{|a| PatientDetail.new(a)}
  end
  def self.in_ward(ward)
    Admission.admitted.where(:currward=>ward).map{|a| PatientDetail.new(a)}
  end

  def initialize(admission)
    @admission = admission
    @patient = admission.patient
  end


  def name
    "#{firstnames} #{lastname}"
  end

end