#include "classSample.h"

ClassSample::ClassSample()
{
    std::cout << "inicializando obj";
    m_objectName = "classSample";
}

ClassSample::~ClassSample()
{
    std::cout << "destruindo obj";
}

void ClassSample::mostrarNomeObjeto()
{
    std::cout << m_objectName;
}
